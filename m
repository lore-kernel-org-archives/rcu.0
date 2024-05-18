Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866F199B8;
	Sat, 18 May 2024 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716074961; cv=none; b=bVtavvGiB5oXlgiGQ9/VdyXYQ3Uv3MrmXi45V0e62vhfkRZqNvX3UEP1brvmF/O5CDOW3zPk79puXwpJG+nz6SwjmbQwe/r57VbhdFHscj4EfDCIrPFkjAPHm888/thakgOPZ4yMWZWvwDhE3ZHK9qmLeGMCOJ9CqLRLp8fmcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716074961; c=relaxed/simple;
	bh=20LiT6eORl7N+sFZOIAjv6c+rmIfYuYXGqqSMA4qp4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=vADoEvGytY9dDDbnoRpsGlXijQhAPgYukPcgVRJjqVU3/kRe1qjUu378pq1gKsoRMCzMn7DzQeMFZMa0J0WFNSyzyFk3CAuoGNDPzfALfCiI/JdjdHB/R1ojyeWUIUaYbuBP1s/Nmj6UcrQ1mGhKMrHzQ3dYAaxsMFaf0fia4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lJwpVmcz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lJwpVmcz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44IN0Dik023950;
	Sat, 18 May 2024 23:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=ezX
	uR+NS0rCVRv5L6Z87gEdQ8sM5xSsxknGGKaYZIyo=; b=lJwpVmcz3L34DPeWRjq
	JrwxnCbHTakdOUuszK8m2my0bLIRLgp1GoLhbZ1GsC/ogMBpznj0FdBFEdn4Nqfe
	pPeCS+FT9xy6NvEnx2SbdIQJcvX14/jUWvFDX1dMlAv/1Qd0JBmMQt2wZRf9HBAc
	aCfSWNDJrvs2o8Gc1/0sKfZFeUnP2pBkUab9dO8OZrXF9UDUzlsHJMMYSz0Ks2tY
	wiY4xKbzeb3dpapQZ+VTGskPNkxPbKz6/1Kj35Dwr593TYGU1aLa/ciw+ZJ3Stxp
	V4Guq1YOcjWVqcgeGzjqDGgenW+Kia1f6dXLWvW8DGDMFV15aNEVhrjgpU62OvXT
	Ytg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4p11w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 23:28:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44INSAQb005977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 23:28:10 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 18 May
 2024 16:28:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 18 May 2024 16:28:08 -0700
Subject: [PATCH] rcu: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240518-rcu-v1-1-086a30b96877@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIc5SWYC/x3MywrCQAyF4VcpWRuYGS06voq4mEu0AR1L0kql9
 N2NLj/4z1lBSZgUzt0KQm9WfjWD33VQhtTuhFzNEFw4uN6fUMqMx+rjPuYag+vBylHoxsv/5XI
 156SEWVIrw2/74DYv+Ew6keD4sRS27QtuK/SPegAAAA==
To: Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Frederic
 Weisbecker" <frederic@kernel.org>,
        Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Boqun
 Feng" <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan
	<jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Uz546PfDqp-ml5aj6jPptnq4kVmncUsa
X-Proofpoint-GUID: Uz546PfDqp-ml5aj6jPptnq4kVmncUsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-18_14,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405180193

Fix the following 'make W=1' warnings:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcutorture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcuscale.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/refscale.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/rcu/rcuscale.c   | 1 +
 kernel/rcu/rcutorture.c | 1 +
 kernel/rcu/refscale.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 8db4fedaaa1e..b53a9e8f5904 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -42,6 +42,7 @@
 
 #include "rcu.h"
 
+MODULE_DESCRIPTION("Read-Copy Update module-based scalability-test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 807fbf6123a7..b0d8d06ab7a8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -51,6 +51,7 @@
 
 #include "rcu.h"
 
+MODULE_DESCRIPTION("Read-Copy Update module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 2c2648a3ad30..f4ea5b1ec068 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -63,6 +63,7 @@ do {											\
 
 #define SCALEOUT_ERRSTRING(s, x...) pr_alert("%s" SCALE_FLAG "!!! " s "\n", scale_type, ## x)
 
+MODULE_DESCRIPTION("Scalability test for object reference mechanisms");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
 

---
base-commit: 674143feb6a8c02d899e64e2ba0f992896afd532
change-id: 20240518-rcu-7d1939bd9205

