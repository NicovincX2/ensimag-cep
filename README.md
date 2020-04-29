# CEP

## Notes

Nous avons réalisé toutes les instructions jusqu'aux interruptions (non obligatoires). Nous avons décidé de nous concentrer sur les jeux de tests. Nous avons ainsi des tests complets traitant tous (du moins on l'espère) les cas limites pour toutes (ou presque) les instructions implémentées.

---

Le test d'`auipc` reste à être amélioré.

La partie commentée du test de `jal` ne donne pas le bon résultat alors que le test nous semble correct. De même pour `jalr`.

Les tests de `lb`, `lbu`, `lh` et `lhu` auraient dû être codé selon le modèle de `lw`.
Le problème semble venir du décodage de `.byte` et de `.half`. Nous avons donc modifié `lb`, `lh` et `lhu` en conséquence. Nous avons gardé commentées certaines instructions n'étant plus fonctionnelle sur ces tests modifiés. Etonnament, `lbu` fonctionne sans soucis après avoir réalisé les modifications de `lb`. Nous ne saurions l'expliquer.


Il serait intéressant d'implémenter des tests supplémentaires sur plusieurs cycles. Ce ne serait plus des tests unitaires.

L'implémentation de fonctions de tests serait très utile. En effet, de nombreux tests suivent la même trame.

---

Concernant la **refactorisation** du code VHDL :
 - trop peu d'indications sur la programmation VHDL pour réaliser une factorisation efficace. Efficace est ici synonyme de code **lisible**, clair, fragmenté.
 - nous avons choisi de donner plus d'importance à la clarté du code qu'à sa possible redondance
 - le grand nombre d'instructions et l'impossibilité - ou l'ignorance du procédé permettant - de créer des fonctions adaptées en VHDL sont limitant,

Concernant le déroulement du projet dans les conditions du confinement :
 - un **cours** de VHDL plus développé nous aurais beaucoup aidé (et épargné de nombreuses heures de débogage qui ne nous ont rien apportés),
 - les enseignants étaient très souvent disponible pour répondre à nos questions,
 - certains enseignants n'apportaient pas de réponse permettant de résoudre nos problèmes,


Nous remercions toute l'équipe enseignante pour avoir assuré les cours et TP pendant cette période de confinement.

## Instruction Status

### Métadonnées

[![timestamp status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//timestamp.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//timestamp.svg)

Fichier de [log](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//log.txt)
### Arithmetiques

[![ADDI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//ADDI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//ADDI.svg)
[![ADD status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//ADD.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//ADD.svg)
[![SUB status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SUB.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SUB.svg)
### Basiques

[![REBOUCLAGE status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//REBOUCLAGE.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//REBOUCLAGE.svg)
[![LUI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LUI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LUI.svg)
### Divers

[![AUIPC status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//AUIPC.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//AUIPC.svg)
### Logiques

[![OR status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//OR.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//OR.svg)
[![ORI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//ORI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//ORI.svg)
[![AND status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//AND.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//AND.svg)
[![ANDI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//ANDI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//ANDI.svg)
[![XOR status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//XOR.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//XOR.svg)
[![XORI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//XORI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//XORI.svg)
### Décalages

[![SLL status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLL.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLL.svg)
[![SLLI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLLI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLLI.svg)
[![SRA status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SRA.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SRA.svg)
[![SRAI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SRAI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SRAI.svg)
[![SRL status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SRL.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SRL.svg)
[![SRLI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SRLI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SRLI.svg)
### Sets

[![SLT status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLT.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLT.svg)
[![SLTI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLTI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLTI.svg)
[![SLTIU status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLTIU.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLTIU.svg)
[![SLTU status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLTU.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SLTU.svg)
### Branchements

[![BEQ status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BEQ.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BEQ.svg)
[![BGE status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BGE.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BGE.svg)
[![BGEU status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BGEU.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BGEU.svg)
[![BLT status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BLT.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BLT.svg)
[![BLTU status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BLTU.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BLTU.svg)
[![BNE status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BNE.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//BNE.svg)
### Sauts

[![JAL status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//JAL.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//JAL.svg)
[![JALR status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//JALR.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//JALR.svg)
### Loads

[![LB status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LB.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LB.svg)
[![LBU status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LBU.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LBU.svg)
[![LH status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LH.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LH.svg)
[![LHU status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LHU.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LHU.svg)
[![LW status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LW.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//LW.svg)
### Stores

[![SB status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SB.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SB.svg)
[![SH status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SH.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SH.svg)
[![SW status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SW.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//SW.svg)
### Interruptions

[![CSRRC status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRC.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRC.svg)
[![CSRRCI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRCI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRCI.svg)
[![CSRRS status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRS.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRS.svg)
[![CSRRSI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRSI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRSI.svg)
[![CSRRW status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRW.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRW.svg)
[![CSRRWI status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRWI.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//CSRRWI.svg)
[![IT status](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//IT.svg)](https://CEP_Deploy.pages.ensimag.fr/projet_cep_G1/Eval/argentoa_vincentn_eval//IT.svg)
