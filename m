Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550B3587CB;
	Mon, 19 Jan 2026 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820227; cv=none; b=ZXH3oM28OMepZCqSToJ2zumRNC6lYnGr4w2OWrC5BqGDaghAUF2fdGO7IXYLZoqIdjjEFXCFsaYYedynh7U7ObO6MoqB5pPnyceXddIH64tryZaXC01SuVPm4nRx88WusPtCftRLv+NU9UVVld/wZEpK5swug2q7DwIgeQGHSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820227; c=relaxed/simple;
	bh=Ci6KpqtrsX1G4JyXv3lQ1+cRtyKWDYI5/MSAX1ZPQuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOUFqC8Q5fGH6CSDNVrcePfhzZdhrZFIuJli6j2WZ6VyJlnxBa7GUUlxGWJcTBl8weHGivkJV2GkYLkG+QyCc6L89Xuz1pxmS5faTy/F0L/eHt+EuuArUQrjJeTWAq+cMYbxUTHc2E0jshf9+bbT26gAFOIu8d905DXaB9px9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lk0PWJ15; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lk0PWJ15"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60INOCqH007907;
	Mon, 19 Jan 2026 10:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sgGVSW
	Nhr3ssUtRtHVBzK3x5wk3NCPfV7jYXFzQTaB0=; b=Lk0PWJ15vihwdKFD8jBnHB
	dd2cUzrFM5LCDaD/onj6U19I1ehe5gtuB+sZzxzFs5LQhezaKfY9lnKzmmUaQull
	JhvZY99DrerZi2EUAce0nzZD4VBLX0GN84DgbDICszwm9F2NpUycynuMXX1KNMwv
	zQfMpNuLQtwpRMV+uvaMIKjM40ST93UCJm3Ar2bFanfXRFLdjU9oeBeJtyV4olF6
	K1gx/4VFWghi/hbLqWnbpCrtdr4qm8Mv15B+sPsyMLdXwf0rxJKLQFg09hhu6OKs
	qx1p1ufpke01K1T/jxYfOlDKrloDUvWPZpi6z4Rlo8LG38siOa2jhXjcBQJeOLuQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyujyea9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 10:56:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JAdD2D003629;
	Mon, 19 Jan 2026 10:56:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyujyea5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 10:56:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JAUiB3027274;
	Mon, 19 Jan 2026 10:56:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrmp82b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 10:56:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JAulWu46989812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 10:56:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4A1220043;
	Mon, 19 Jan 2026 10:56:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D90B20040;
	Mon, 19 Jan 2026 10:56:43 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.221.29])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 10:56:42 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [RESEND] [PATCH] cpuhp: Expedite synchronize_rcu during SMT switch
Date: Mon, 19 Jan 2026 16:24:08 +0530
Message-ID: <20260119105407.440558-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113090153.GS830755@noisy.programming.kicks-ass.net>
References: <20260113090153.GS830755@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4OSBTYWx0ZWRfXyoduZYqYwB9K
 fOEzPicrIDun6tR2BcIqPE0lukC4oL37Ed/xbhbScnCYG7PuY3t0zTO9SmZfEnmPzZuZDbww3ow
 wFlah7P0kuT1hH1ZEbYaCDtsy4Xex+rvVkay4lZTzAV/S9f1crjrA8DCfknGC8JtpCdWyBkRwHx
 WNViN8F8YwHwzaGf+XbUl8ysxrjztDr6EyjdO4FTHB+dN7pWcgyrK+ZqywBa0v1o9+txfigJXD3
 xEpWHIzqFiA/Bv9CvTf64syPfLYEZjsbfVqFQJdzb3gpPh7Bk6vSMAlhPJqg/L7Qmzg2lK2fiQ3
 hQGnsirpNYjYyg21ksPc0Bg4jfevkTqMoVIw33JfGC8arGYihrymPyW0DEFaRmLqoKKWyS5sJ8p
 OpGJXJAOeU7DzvnanoRFGWO+wRYhLV1W9Jb65wHqqa4svwu7lRHPOPCY1phJp8cmLyn0gpZF+Zq
 79WncyCrhTCj6f35pgA==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=696e0df5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8 a=JfrnYn6hAAAA:8
 a=OkdqqSPGjW8kWkNQwFwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H4LAKuo8djmI0KOkngUh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: lMo4r_IyxkSsAMRWBwz_gmYextjYBCyJ
X-Proofpoint-GUID: aVDbeq0p3ug65WWOABGooJ1nVrV9kI_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190089

[Edits] Added Suggested-by tag

Expedite synchronize_rcu() during the cpuhp_smt_[enable|disable] path to
accelerate the operation.

Bulk CPU hotplug operations—such as switching SMT modes across all
cores—require hotplugging multiple CPUs in rapid succession. On large
systems, this process takes significant time, increasing as the number
of CPUs to hotplug during SMT switch grows, leading to substantial
delays on high-core-count machines. Analysis [1] reveals that the
majority of this time is spent waiting for synchronize_rcu().

SMT switch is a user-initiated administrative task, it should complete
as quickly as possible.

Performance data on a PPC64 system with 2048 CPUs:

+ ppc64_cpu --smt=1 (SMT8 to SMT1)
Before: real 30m53.194s
After:  real 6m4.678s  # ~5x improvement

+ ppc64_cpu --smt=8 (SMT1 to SMT8)
Before: real 49m5.920s
After:  real 36m47.798s  # ~1.3x improvement

[1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
[2] https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Tested-by: Samir M <samir@linux.ibm.com>

---
 include/linux/rcupdate.h | 3 +++
 kernel/cpu.c             | 4 ++++
 2 files changed, 7 insertions(+)

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
index 8df2d773fe3b..a264d7170842 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2669,6 +2669,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_expedite_gp();
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
@@ -2698,6 +2699,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	}
 	if (!ret)
 		cpu_smt_control = ctrlval;
+	rcu_unexpedite_gp();
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2716,6 +2718,7 @@ int cpuhp_smt_enable(void)
 
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
+	rcu_expedite_gp();
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
@@ -2728,6 +2731,7 @@ int cpuhp_smt_enable(void)
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	rcu_unexpedite_gp();
 	cpu_maps_update_done();
 	return ret;
 }
-- 
2.52.0

