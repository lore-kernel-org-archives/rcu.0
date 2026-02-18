Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96284271A6D;
	Wed, 18 Feb 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404069; cv=none; b=lmr1q2PuX7k3N1VhN24U52qpfI83/YNE7om3YLOekEeoCYJYeClF1pGLzZc7v9h6Oei4qW4qZdUofNuPKevtX0AL2oNQf6X4aOwVQ+EzA+P1CdaO+8G0LbQx1JJ95qbZjrMchNNeTRT0JKEpwwj7i0Irj55X/CUYkwVrMDAggg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404069; c=relaxed/simple;
	bh=tnXxV+5eAHkXe8/44nME9yzsjXr44OYxaADpsX5yF2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMphZtJEfdgutyYqvucy+bbEDbz5NCjR/3htyJdMNq96URQXKnaYaePzFNjC6SULuAEXzzHTkQKY2Uy1nH/LoESK3eQ/zZBkttbeijlq010RKbOC20IEftnDYW38jEnnRHojFWTdfz2H4KJlGpQGIt7L5gkCUKG59WTjozkeECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fK6fF6zC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fK6fF6zC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HJiLvx3447192;
	Wed, 18 Feb 2026 08:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s7sJDReKfJfFyfc7U
	KmqUGoj4k3WGB4lH+DBuG6J6sk=; b=fK6fF6zCGFvYsP3tgb47oiOB14QfycX1R
	lBo6TxI+Sig9INR8poZ1igLRFO1uAc3KfbZlBZjXvcNQ3XRPRzAzftI/0zxXApTm
	Z5AGBX6LB/FHYIp6lvcPTh1DIump7RkCyiwnk2SMl2vvmysn4MCmJWRFGCNhXiMG
	HS8cEKhVHzuvOhgcShiYCYD/LbSvPJaxg/BhpAYGntD++xCl5kzq8TPlkWwbewsp
	0h+87y9M4ohLY12ZOAUyEB7+4v49Y+YinP4xvld2KBzSMKLExRT7KI188wbp8EFU
	jftte9/j93eCnv4RfMU0Er87rA+FdU2islCPw+Fb7XkMWZC1La8zQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s0ax8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 08:40:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61I2qebO030213;
	Wed, 18 Feb 2026 08:40:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4572bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 08:40:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61I8enc052101500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 08:40:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 527CF2004D;
	Wed, 18 Feb 2026 08:40:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B09C20043;
	Wed, 18 Feb 2026 08:40:45 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.221.53])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 08:40:44 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH v3 1/2] cpuhp: Optimize SMT switch operation by batching lock acquisition
Date: Wed, 18 Feb 2026 14:09:16 +0530
Message-ID: <20260218083915.660252-4-vishalc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69957b16 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=WsHKUha7AAAA:8 a=Ikd4Dj_1AAAA:8
 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=KN9s3eCRc324pKJoVuoA:9
 a=H4LAKuo8djmI0KOkngUh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 8EagpurTVSAuSPmQx1wjwrSOsI5tbP3W
X-Proofpoint-ORIG-GUID: epiz1Z7hVF7WSjbJJ7y7ZrDDkTjskWuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3NSBTYWx0ZWRfX2WC55NwRMCZ4
 ZHOZr5B4ZpuBo+1Rpq6LxpIJu432vpglc3yoPGn8FZ5vMrs9S2a+vWxdV5ofU+3q7USok/f06rF
 0Z3K6jkBd52jbv1m/59QYM7CbPDjqbFn20D3VLPlGOQyRObEvx5zD+6Ml558O3NUn0281R9H0oj
 iFPNng98eVKckj0xPx8Ggsu6NaqZ6gXhwtaTZbLirmMeF0aChsTqY3ORtMz2QooIhEnRUwhzaI/
 9Z+tETZqIaKisiFGbT4XNun0ZREB9M/zFNaMm5si8W17aVPPf7WY3zJvKL0AubnMDONy7WuuhxU
 WA5bgOOHi3KIgq3DodLjN9nebpyxcjyD3pquDAgXyKD4CIDECIH+tNvQk2I9wne3SLHVugRBEWA
 NTyN4Q2bE5uozDmPbqjYOauTWKNoBdnqk3kWoab4EgUSQXTJMAaLK2JzVM/1ZUToroIC8u6miF1
 dnO+SNqVQfe1Sifkt4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180075

From: Joel Fernandes <joelagnelf@nvidia.com>

Bulk CPU hotplug operations, such as an SMT switch operation, requires
hotplugging multiple CPUs. The current implementation takes
cpus_write_lock() for each individual CPU, causing multiple slow grace
period requests.

Introduce cpu_up_locked() and cpu_down_locked() that assume the caller
already holds cpus_write_lock(). The cpuhp_smt_enable() and
cpuhp_smt_disable() functions are updated to hold the lock once around
the entire loop, rather than for each individual CPU.

Link: https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 kernel/cpu.c | 72 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 01968a5c4a16..62e209eda78c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1400,8 +1400,8 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 	return ret;
 }
 
-/* Requires cpu_add_remove_lock to be held */
-static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
+/* Requires cpu_add_remove_lock and cpus_write_lock to be held */
+static int __ref cpu_down_locked(unsigned int cpu, int tasks_frozen,
 			   enum cpuhp_state target)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
@@ -1413,7 +1413,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	if (!cpu_present(cpu))
 		return -EINVAL;
 
-	cpus_write_lock();
+	lockdep_assert_cpus_held();
 
 	/*
 	 * Keep at least one housekeeping cpu onlined to avoid generating
@@ -1421,8 +1421,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 */
 	if (cpumask_any_and(cpu_online_mask,
 			    housekeeping_cpumask(HK_TYPE_DOMAIN)) >= nr_cpu_ids) {
-		ret = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 
 	cpuhp_tasks_frozen = tasks_frozen;
@@ -1440,14 +1439,14 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 		 * return the error code..
 		 */
 		if (ret)
-			goto out;
+			return ret;
 
 		/*
 		 * We might have stopped still in the range of the AP hotplug
 		 * thread. Nothing to do anymore.
 		 */
 		if (st->state > CPUHP_TEARDOWN_CPU)
-			goto out;
+			return 0;
 
 		st->target = target;
 	}
@@ -1464,8 +1463,16 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 			WARN(1, "DEAD callback error for CPU%d", cpu);
 		}
 	}
+	return ret;
+}
 
-out:
+static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
+			   enum cpuhp_state target)
+{
+
+	int ret;
+	cpus_write_lock();
+	ret = cpu_down_locked(cpu, tasks_frozen, target);
 	cpus_write_unlock();
 	arch_smt_update();
 	return ret;
@@ -1613,18 +1620,18 @@ void cpuhp_online_idle(enum cpuhp_state state)
 	complete_ap_thread(st, true);
 }
 
-/* Requires cpu_add_remove_lock to be held */
-static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
+/* Requires cpu_add_remove_lock and cpus_write_lock to be held. */
+static int cpu_up_locked(unsigned int cpu, int tasks_frozen,
+			 enum cpuhp_state target)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	struct task_struct *idle;
 	int ret = 0;
 
-	cpus_write_lock();
+	lockdep_assert_cpus_held();
 
 	if (!cpu_present(cpu)) {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/*
@@ -1632,14 +1639,13 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 	 * caller. Nothing to do.
 	 */
 	if (st->state >= target)
-		goto out;
+		return 0;
 
 	if (st->state == CPUHP_OFFLINE) {
 		/* Let it fail before we try to bring the cpu up */
 		idle = idle_thread_get(cpu);
 		if (IS_ERR(idle)) {
-			ret = PTR_ERR(idle);
-			goto out;
+			return PTR_ERR(idle);
 		}
 
 		/*
@@ -1663,7 +1669,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 		 * return the error code..
 		 */
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/*
@@ -1673,7 +1679,16 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 	 */
 	target = min((int)target, CPUHP_BRINGUP_CPU);
 	ret = cpuhp_up_callbacks(cpu, st, target);
-out:
+	return ret;
+}
+
+/* Requires cpu_add_remove_lock to be held */
+static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
+{
+	int ret;
+
+	cpus_write_lock();
+	ret = cpu_up_locked(cpu, tasks_frozen, target);
 	cpus_write_unlock();
 	arch_smt_update();
 	return ret;
@@ -2659,6 +2674,16 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	if (cpu_hotplug_offline_disabled) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+	if (cpu_hotplug_disabled) {
+		ret = -EBUSY;
+		goto out;
+	}
+	/* Hold cpus_write_lock() for entire batch operation. */
+	cpus_write_lock();
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
@@ -2668,7 +2693,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		 */
 		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
 			continue;
-		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
+		ret = cpu_down_locked(cpu, 0, CPUHP_OFFLINE);
 		if (ret)
 			break;
 		/*
@@ -2688,6 +2713,9 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	}
 	if (!ret)
 		cpu_smt_control = ctrlval;
+	cpus_write_unlock();
+	arch_smt_update();
+out:
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2705,6 +2733,8 @@ int cpuhp_smt_enable(void)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	/* Hold cpus_write_lock() for entire batch operation. */
+	cpus_write_lock();
 	cpu_smt_control = CPU_SMT_ENABLED;
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
@@ -2712,12 +2742,14 @@ int cpuhp_smt_enable(void)
 			continue;
 		if (!cpu_smt_thread_allowed(cpu) || !topology_is_core_online(cpu))
 			continue;
-		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
+		ret = cpu_up_locked(cpu, 0, CPUHP_ONLINE);
 		if (ret)
 			break;
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	cpus_write_unlock();
+	arch_smt_update();
 	cpu_maps_update_done();
 	return ret;
 }
-- 
2.53.0

