#!/bin/bash

# Script d'auto-commit pour générer de l'activité GitHub
# Usage: ./auto_commit.sh [nombre_de_commits]

# Couleurs pour l'affichage
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Nombre de commits (par défaut 10)
NUM_COMMITS=${1:-10}

# Vérifier si on est dans un repo git
if [ ! -d .git ]; then
    echo -e "${RED}❌ Erreur: Ce n'est pas un repository git${NC}"
    exit 1
fi

# Créer ACTIVITY_LOG.md s'il n'existe pas
if [ ! -f ACTIVITY_LOG.md ]; then
    echo "# 📊 Activity Log" > ACTIVITY_LOG.md
    echo "" >> ACTIVITY_LOG.md
    echo "## Statistiques" >> ACTIVITY_LOG.md
fi

echo -e "${BLUE}🤖 GitHub Activity Generator${NC}"
echo -e "${BLUE}📊 Nombre de commits prévus: ${NUM_COMMITS}${NC}"
echo -e "${YELLOW}⏱️  Intervalle aléatoire: 3-10 secondes${NC}"
echo ""

# Types de modifications possibles
MODIFICATIONS=(
    "update_log"
    "add_stat"
    "update_counter"
    "add_timestamp"
)

for i in $(seq 1 $NUM_COMMITS); do
    echo -e "${GREEN}[${i}/${NUM_COMMITS}] Génération d'activité...${NC}"
    
    # Choisir aléatoirement un type de modification
    MOD_TYPE=${MODIFICATIONS[$RANDOM % ${#MODIFICATIONS[@]}]}
    
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    case $MOD_TYPE in
        "update_log")
            echo "- Activity generated at ${TIMESTAMP}" >> ACTIVITY_LOG.md
            COMMIT_MSG="Update activity log"
            ;;
        "add_stat")
            echo "" >> ACTIVITY_LOG.md
            echo "**Commit #${i}** - Generated on ${TIMESTAMP}" >> ACTIVITY_LOG.md
            COMMIT_MSG="Add activity statistics"
            ;;
        "update_counter")
            echo "Total automated commits: ${i}" >> ACTIVITY_LOG.md
            COMMIT_MSG="Update commit counter"
            ;;
        "add_timestamp")
            echo "${TIMESTAMP} - Automated activity" >> ACTIVITY_LOG.md
            COMMIT_MSG="Log timestamp activity"
            ;;
    esac
    
    # Délai aléatoire entre 3 et 10 secondes
    DELAY=$((3 + RANDOM % 8))
    echo -e "${YELLOW}⏳ Attente de ${DELAY} secondes...${NC}"
    sleep $DELAY
    
    # Git add
    git add .
    
    # Git commit
    git commit -m "${COMMIT_MSG} - ${TIMESTAMP}"
    
    # Git push
    git push
    
    echo -e "${GREEN}✅ Activité ${i}/${NUM_COMMITS} générée${NC}"
    echo ""
done

echo -e "${BLUE}🎉 Génération d'activité terminée!${NC}"
echo -e "${GREEN}📈 ${NUM_COMMITS} commits créés avec succès${NC}"