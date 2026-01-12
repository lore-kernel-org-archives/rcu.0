Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58EF30F95C;
	Mon, 12 Jan 2026 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211079; cv=none; b=dcwlUse+0rGmsUivgMZnJj+nnwOh8YoaA2xZ52Hj10VBI3X6wcLS/r7/6WsM+7zrvzSFt1+DvJ24r4uBdm2XNTpB62M8gFhYhu/kJKZ3O6UFMv/bSWZsqvLz/NsBs5t/zPdKy3XgPxRk6PywVIQ3TwZ84Ss2dfFg8UZctt+t5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211079; c=relaxed/simple;
	bh=cKRsMBTkEby3VsIZ0I1r+vO/hRrd07dRTyIZs5WmSFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMI3MhZOHfluGyfipe77TUwQqxRFoj+xinlo+L5MecmQC5SO50yCJYX6WLl3MqWUU1oVS2WsN7ziIUGL5d0j2T4j95Wh9UlqNMKfgv3Nfok/yi9zhNhIowNFvja8lOE5m+gARiMxCN+imqzZk1FElcUy0ikIBEsZxRBqyJ1DzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZJCoQQlZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZJCoQQlZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C7Y5sm026893;
	Mon, 12 Jan 2026 09:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=lOOKom/8LwFx0k85Gz6VenK07CzY
	lrU/6IB4T158LrE=; b=ZJCoQQlZS/H7VCmDlDovpm+9h89lgygWYZHKs5l7UNV3
	VDUEhtOtfRboSuhpnAr37FfyJtlAb4wxKlMLvut62h4HzY5o3e3TCrDkiolB+FJW
	p5vsEyxa4V8mwgBLVcO0kfU8khS/tEbPqyHKvCJoJ+cWK+fIOsh04YJjwZpuuygL
	BTMGDy7xYSc1qVEKABsFifY9zBTvZatnjoKp1TrNzCj73hRz+DunAi4tWu6kaWm3
	PkfsuKrp7y0puI4vGJlxK5hTRhe3Un5F8w7uEnU3tQg7tdWmCE8ZzJpJTRNM3/Zo
	7AHy8cXYGU7p98UqHfOF3DUrhlITmn2H/xK5r7uj6w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxcmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 09:44:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60C9duUO019416;
	Mon, 12 Jan 2026 09:44:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxcmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 09:44:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9H1f4002536;
	Mon, 12 Jan 2026 09:44:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sdc7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 09:44:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60C9iHcG50987382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 09:44:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 370A620043;
	Mon, 12 Jan 2026 09:44:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F4BB20040;
	Mon, 12 Jan 2026 09:44:12 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.17.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 09:44:12 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
        joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
        urezki@gmail.com, rostedt@goodmis.org, tglx@linutronix.de,
        peterz@infradead.org, sshegde@linux.ibm.com, srikar@linux.ibm.com,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug operations
Date: Mon, 12 Jan 2026 15:13:33 +0530
Message-ID: <20260112094332.66006-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VLwUjosUDj7m0zxcJFYC490I6NzwoaYH
X-Proofpoint-ORIG-GUID: SL1DkH3fW4E0sfvDbx4QtqyVDbgzyMSF
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6964c276 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ciYaQ0eq0LbTsZo9SXEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA3MiBTYWx0ZWRfX5EPLL3VJgH6W
 gp/eJySXsIRl1ze43RKJE3BldNx5lDoO6HxNamoaMPbDJqopPH9JCvqotu1gjkYp2IRaBBJhuv/
 u73ZvZYbzCMJssU8QSG65fMKAXFpdf8b25EFgtJx6OcTs9WgOpMD+HREXJH33rO6rv0bPXFu3YJ
 qvLgbXJc0b4z9N4nOucm/wqvk3MpTiV/xPfkivL1ISFC8ydO66rF8ZQNtH0cH1uTHjq+BWjZ3VM
 9D+dXCe/8qgUxlz98yyj34Txm6Bt4b+4rGQgDbVP1OMr8KqhsYjXHHBKw/yF9Y0GX48QjG/CRVm
 enCYBdPetdX6b6/FZRgiaK0hcd41FlqAQJUzbAIAKBXNerMmzOWJgbpCMsNUXP0B/TbCdczA8jO
 MfiTiE00WOC0EgYya2NOwz1rZgfc1UMCpFbxbARHOXOusxZkiQt6y0DQOXW8aMe8Y7vhZ1fo3nX
 gePxoLImDxq3FkeRJgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120072

Bulk CPU hotplug operations—such as switching SMT modes across all
cores—require hotplugging multiple CPUs in rapid succession. On large
systems, this process takes significant time, increasing as the number
of CPUs grows, leading to substantial delays on high-core-count
machines. Analysis [1] reveals that the majority of this time is spent
waiting for synchronize_rcu().

Expedite synchronize_rcu() during the hotplug path to accelerate the
operation. Since CPU hotplug is a user-initiated administrative task,
it should complete as quickly as possible.

Performance data on a PPC64 system with 400 CPUs:

+ ppc64_cpu --smt=1 (SMT8 to SMT1)
Before: real 1m14.792s
After:  real 0m03.205s  # ~23x improvement

+ ppc64_cpu --smt=8 (SMT1 to SMT8)
Before: real 2m27.695s
After:  real 0m02.510s  # ~58x improvement

Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b

[1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 include/linux/rcupdate.h | 3 +++
 kernel/cpu.c             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c5b30054cd01..03c06cfb2b6d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1192,6 +1192,9 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
+extern void rcu_expedite_gp(void);
+extern void rcu_unexpedite_gp(void);
+
 DEFINE_LOCK_GUARD_0(rcu,
 	do {
 		rcu_read_lock();
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8df2d773fe3b..6b0d491d73f4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -506,12 +506,14 @@ EXPORT_SYMBOL_GPL(cpus_read_unlock);
 
 void cpus_write_lock(void)
 {
+	rcu_expedite_gp();
 	percpu_down_write(&cpu_hotplug_lock);
 }
 
 void cpus_write_unlock(void)
 {
 	percpu_up_write(&cpu_hotplug_lock);
+	rcu_unexpedite_gp();
 }
 
 void lockdep_assert_cpus_held(void)
-- 
2.52.0

