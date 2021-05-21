Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA858C433ED
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 10:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8766C613CB
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 10:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhEUKKm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 06:10:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3926 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233350AbhEUKKk (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 21 May 2021 06:10:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LA36ZL055466;
        Fri, 21 May 2021 06:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=GU3OgEF71usx2GCy1UvEbNnrKwsrwrSyWiTISbRlXoA=;
 b=nbi9Lj57QkFqP0g5c38OJ/cGYseNYyriFy3MS+e8AwcSoq3MuR7wl5rhDZhFJQfGaJyn
 yzEbjfW+LQ2eqrZiM0nX1BOUS6bTJzrLmTKy181+ncSZaXZlGKr70uXvAi2i08lECcA/
 5ctiIR0uujaCSZIzEp3waTjSgKKSLGQvockGu65jgP5vGFR22d31Pj/KtAJJv8VFkcPt
 2+8wTx5W2UAwHNwUZKlzOI2LVl0gIGSmRx/MhDfQm/ke/F3uvNif8+BVbMOXSZ9W1xD9
 hqS6KaPqmo5HZdz3RTuM+V/RA+PpqeeJKe5/Yp0/w2YCkt5xwrrSa4YrfbafuWJ+ihB0 oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38p9kvt78h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 06:08:45 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14LA3jE0057052;
        Fri, 21 May 2021 06:08:44 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38p9kvt77w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 06:08:44 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LA0Abc024340;
        Fri, 21 May 2021 10:08:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 38j5x89q8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 10:08:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LA8eDg32702878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 10:08:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40C33A405B;
        Fri, 21 May 2021 10:08:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5A67A4054;
        Fri, 21 May 2021 10:08:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 10:08:39 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rculist: unify documentation about missing list_empty_rcu()
Date:   Fri, 21 May 2021 12:08:29 +0200
Message-Id: <20210521100829.257385-1-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uxqhgkbKAHIHcuc0wQ4DuKMWdlcFymhX
X-Proofpoint-ORIG-GUID: x37O0_AqHiZCK-KmNum_OKFu-2nBw7I5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_03:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210061
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We have two separate sections that talk about why list_empty_rcu()
is not needed, consolidate them.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 include/linux/rculist.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index f8633d37e358..f8f42ce04382 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -10,15 +10,6 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 
-/*
- * Why is there no list_empty_rcu()?  Because list_empty() serves this
- * purpose.  The list_empty() function fetches the RCU-protected pointer
- * and compares it to the address of the list head, but neither dereferences
- * this pointer itself nor provides this pointer to the caller.  Therefore,
- * it is not necessary to use rcu_dereference(), so that list_empty() can
- * be used anywhere you would want to use a list_empty_rcu().
- */
-
 /*
  * INIT_LIST_HEAD_RCU - Initialize a list_head visible to RCU readers
  * @list: list to be initialized
@@ -334,6 +325,12 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * list_first_entry() because they would be protected by a lock that blocks
  * writers.
  *
+ * list_empty() fetches the RCU-protected pointer and compares it to the address
+ * of the list head. But it neither dereferences this pointer itself, nor
+ * provides this pointer to the caller. Therefore it is not necessary to use
+ * rcu_dereference(), and list_empty() can be used anywhere you would want to
+ * use a list_empty_rcu().
+ *
  * See list_first_or_null_rcu for an alternative.
  */
 
-- 
2.25.1

