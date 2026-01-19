Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947D357A2F;
	Mon, 19 Jan 2026 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819751; cv=none; b=Qdxptt0YRn70ZZSTOu8t72z0SE7E15151lYzhlykFdrGul2BzVksRoThT4f6fS1QhG4oMQobJNMtoWihrN5bXBm3CyxUk/j0hNkmzQozfy5KE6Ves2W01Un4YqmPDIpU7wJt7VGkzRGfozADX4Qfg5jarNBf+N+EW6/y6x43cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819751; c=relaxed/simple;
	bh=AGEqwuzZ4+QSolrQpNi9QtmiFixXtKDpWqN3dRP5+HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyj1g36/8OIWxNfY7XW1qwBIiW+07WPfocQSQZpCUOnwNYV+//NhqkW4hcqPen6CddwAgtXUAbmMBVm2+dEJJv4Fwz6cA1D2g4oT62prjc0o6SKlQiUQv3uijk0N4EtmLmol+Wb14LheoK3I7bEZDFI21bSQD0ceBHwLz+2szkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XmtWkEsj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XmtWkEsj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60J4CY6f006898;
	Mon, 19 Jan 2026 10:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZoDTAU
	T4IbkImzKqM90k/6VKJ+C8f3pMHp5QIqhEK6I=; b=XmtWkEsjX9it0rPhHcmeYF
	dELI7SSDoZj9K5jA8zvhtc3VMBHjObgC8R9fUCFMwudygMFzzYAMZuiCPFkxyBGF
	p0oNXmUxmaIwPUbaV6cWlS0WmzNep/7epvo73p90ujzu4L1qwREjLYQLJnXcgxhy
	/CrKjw0vSpkVil34yVBUldnL0r09KKVc2c5z+8mLIdPYj5ym9y9JsStQdlALTV4j
	Kiwlb1PiQyVzQapb4tyMrGzfdstzHnL1ZzCxyLYFo5gAZSbZw4vkephtbkMLuDqA
	OA9rOPho/IH27JiSnk7iatpZg2REg3HA40gN27MfWF/yqgr4z4JRPbW4Jx+blRTA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4yrj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 10:48:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JAkpkM019839;
	Mon, 19 Jan 2026 10:48:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4yrj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 10:48:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J8AJIC001152;
	Mon, 19 Jan 2026 10:48:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyje0h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 10:48:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JAmfWW30933410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 10:48:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A2C52004D;
	Mon, 19 Jan 2026 10:48:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27B272004B;
	Mon, 19 Jan 2026 10:48:37 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.221.29])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 10:48:36 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH] cpuhp: Expedite synchronize_rcu during SMT switch
Date: Mon, 19 Jan 2026 16:17:40 +0530
Message-ID: <20260119104739.439799-2-vishalc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=R8AO2NRX c=1 sm=1 tr=0 ts=696e0c0e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=OkdqqSPGjW8kWkNQwFwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EM-K8epMUORgwKOWeRm5J3Lf-5HDit8F
X-Proofpoint-GUID: s_gNKQOnjcKmriXKz5dPLkmjb0f_Y-Hw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4OSBTYWx0ZWRfX3HePacz4m5ec
 FfXBdPtVnEsTVmvU5CyphcFJBa+SaLlKkMO+VbLQg++ukKxgfnsH1896KgZtpTCB6EwnQzBgiGH
 jo0c8ZU5VJwnXKt2pYibuhZn5ysHFBQCGUtije5k1Z34cs6NTF4e1MUE/fjrSFSRh5TBZhvbEgg
 QfVrFa9+e2KwuN3MpTSH4GvRTPULpbRS+PqR10OhLS1uLDcQvPgMd1vI3OOB9nvlpuFFttUK+qW
 Vu9pm1GGDG7g+KWAUfEgZhU1mGVwzql50z80ir3jrUb4vjSkmvrX2O6ZIyEtr5rbYqcH4CNATvs
 VBIiEtB/WVvspw37uQFWF5PWkdoOmOUzCJKDLUDSq1jndOCiZPrLBwmS1V4/63sHmTgiTDXFC99
 l2qm/FstXQtlfy+OIZx0Uk1z3zgW4KjOfJGann5aSYB56WItlLJ/Ztiz2OmhJlbxGFUTSho53pF
 Qy3364ro/pd9dpaUnMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190089

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

