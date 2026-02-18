Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621F2D9EED;
	Wed, 18 Feb 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404110; cv=none; b=lrNNViCQqw/T6jxQazxH1BSBdiIELcpxBfRvqBQXBYv6VTnxCK50p5Iv9QcL55mDb+jz4n+83r7FLfDsXjf0Q3/P8ab/qxg49fYVCsnt8EAEqOeCKmuEfwpX3Hhm5rzqt23oYbvBJbOtCdYURle2g7WRCgX0fjh6UmT0veJ+eZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404110; c=relaxed/simple;
	bh=K1K0gh81zux1ZtPoUuKlhlJnYR8MPrLkTHDf5WkU1j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKUgsCKfEcMnZpddzKxWWWwyoqD9GCC/Pm/OnhcRLqC9cZY99SavIM7dP4Xtt0vXLYP1mhft1V5j9kWDHD7Mti7vu0YC7RjVzH/Xsa2QUk2rB9Bi6wCoN43HWdj0lDHSEKKdVBC2ufuMmefDjsMvQaEYe7f+aUeQSMCLmEQBlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MppNgAs5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MppNgAs5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HJ2xmN3475047;
	Wed, 18 Feb 2026 08:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+C+faj6wKVh/I/Bt2
	mj7oGKj4M5bzevVQmRhu/NjvEI=; b=MppNgAs5DVdCDML+ikO/+e3o26m08RuhV
	YNY/gqI3Yu+p4+h9EdSH3jd4rrIxXSLim5gtCUividQNIdnScTnOKnjZKq0K7RHG
	HsRe8L8+E7uVzseKCFsG4nmGbcDIGYhUYAyb7RiE/m9EjhKobQwOq8NownYIc/PJ
	l1s7dpkQueEg07rahpINa2St4j9IqmlJMKU4y0ReViCeu0h8eR7ri30rTOG0Af2H
	v+CCW1LV+xOnSE2zuECiS5U2m/eixDSD7e9gdjpQFXieGFqLvHAPBPJRL02s5XkL
	dzR5NEbqJbrxJNucyxQnJ5OZVjAad9fk+XE04SkoTXVM3zcFv9Bbw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6urb1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 08:41:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61I8dHix030187;
	Wed, 18 Feb 2026 08:41:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4572dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 08:41:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61I8fUge31129926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 08:41:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 315E320043;
	Wed, 18 Feb 2026 08:41:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0958B2004B;
	Wed, 18 Feb 2026 08:41:25 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.221.53])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 08:41:24 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH v3 2/2] cpuhp: Expedite RCU grace periods during SMT operations
Date: Wed, 18 Feb 2026 14:09:18 +0530
Message-ID: <20260218083915.660252-6-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218083915.660252-2-vishalc@linux.ibm.com>
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=69957b3f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8
 a=PqvyiyzHRLmJk8HVyFUA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3NSBTYWx0ZWRfXzB0yL864ITHz
 AiyOiUsd8qOFKUKw3SveIEGQ88bGW4UmIbKVl+sArxNf5aOXcM5c7aE8/eG7sV3c7qbX7++wIfF
 tf/5De6pfdI2fPwWQUiqoh52n6/eIUzaFT1m5WsOuKvh4bbi+oHigEzeJpp8JK6ibNIR5dmNzUy
 I0gRRJzAV8yj1Q4vhGFiR+7eqZ6H0tpjpdacnl9To9F2OTt4ZsRZc2mfWL6vYF/sPKfHXPYVspH
 gnhfn0KPlRDhm5dFFXzqLZ7n2Ha+S5vQU3unX1LT9JqDkVkiFtQ3A+iIDQl9Kp/dstgLqNU20St
 ncgYJD8BpfuwFMVbtpgzZB44r5lag7Qwq8qKBheAnvzNO5H62JvP/Lri7kM54LpqCgi33TjXRRJ
 S0tA+w6JCAtI4bMCv6rQe/z79wEmtLRnM4Cr/WVXVzqWIV2xqll9uhReFcKPeTCuJpyh2DH59AU
 CoM0/aE3gYkzE2uloqA==
X-Proofpoint-ORIG-GUID: z8sEk4COgYcgFGHd_3ZdxldZvuH9uFYB
X-Proofpoint-GUID: wVqDBaLV9N5mvkQk-gxpLpRWZGgXaLG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180075

Expedite synchronize_rcu during the SMT mode switch operation when
initiated via /sys/devices/system/cpu/smt/control interface

SMT mode switch operation i.e. between SMT 8 to SMT 1 or vice versa and
others are user driven operations and therefore should complete as soon
as possible. Switching SMT states involves iterating over a list of CPUs
and performing hotplug operations. It was found these transitions took
significantly large amount of time to complete particularly on
high-core-count systems.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 include/linux/rcupdate.h | 8 ++++++++
 kernel/cpu.c             | 4 ++++
 kernel/rcu/rcu.h         | 4 ----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 7729fef249e1..61b80c29d53b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1190,6 +1190,14 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
+#ifdef CONFIG_TINY_RCU
+static inline void rcu_expedite_gp(void) { }
+static inline void rcu_unexpedite_gp(void) { }
+#else
+void rcu_expedite_gp(void);
+void rcu_unexpedite_gp(void);
+#endif
+
 DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
 DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 62e209eda78c..1377a68d6f47 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2682,6 +2682,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		ret = -EBUSY;
 		goto out;
 	}
+	rcu_expedite_gp();
 	/* Hold cpus_write_lock() for entire batch operation. */
 	cpus_write_lock();
 	for_each_online_cpu(cpu) {
@@ -2714,6 +2715,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	if (!ret)
 		cpu_smt_control = ctrlval;
 	cpus_write_unlock();
+	rcu_unexpedite_gp();
 	arch_smt_update();
 out:
 	cpu_maps_update_done();
@@ -2733,6 +2735,7 @@ int cpuhp_smt_enable(void)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_expedite_gp();
 	/* Hold cpus_write_lock() for entire batch operation. */
 	cpus_write_lock();
 	cpu_smt_control = CPU_SMT_ENABLED;
@@ -2749,6 +2752,7 @@ int cpuhp_smt_enable(void)
 		cpuhp_online_cpu_device(cpu);
 	}
 	cpus_write_unlock();
+	rcu_unexpedite_gp();
 	arch_smt_update();
 	cpu_maps_update_done();
 	return ret;
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index dc5d614b372c..41a0d262e964 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -512,8 +512,6 @@ do {									\
 static inline bool rcu_gp_is_normal(void) { return true; }
 static inline bool rcu_gp_is_expedited(void) { return false; }
 static inline bool rcu_async_should_hurry(void) { return false; }
-static inline void rcu_expedite_gp(void) { }
-static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_async_hurry(void) { }
 static inline void rcu_async_relax(void) { }
 static inline bool rcu_cpu_online(int cpu) { return true; }
@@ -521,8 +519,6 @@ static inline bool rcu_cpu_online(int cpu) { return true; }
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 bool rcu_async_should_hurry(void);  /* Internal RCU use. */
-void rcu_expedite_gp(void);
-void rcu_unexpedite_gp(void);
 void rcu_async_hurry(void);
 void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
-- 
2.53.0

