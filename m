Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606930DD30;
	Mon, 16 Feb 2026 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244438; cv=none; b=r44UBFW0Sy3ics9Wssj0Nf6NXp2V1TJ3HbnvnxJE3bbbETW/6+c3lir3CiTDk+8SZDFJOROcqtpoo3gn72DO+u5nsxp0uquZmNE633iGy44gXh+eLwJHd4PM5WouOu0LQ5/kyyZebVb8SaHI5NkddDdvN3PYaQ31/F9MAJDWilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244438; c=relaxed/simple;
	bh=wmW21vC8zXi9EyVLbDRmK2ycBDUsW7be6o/W1oiyyIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtDIYRe3E6Kp9aY21AJvPBiLdFa8IsVwJPpduStXpUpw1RyoHMCmJJLhTs9l9lbZIJlhNQF33dqMOw0qN+sCrVKDToEkCdS9c3NONPvbPH9D3KREK+S+h+iIr5HDDXCPHRJ+nWzAnOVZLVQ5ETlD8w01FyuwVkQnOKeV9QxJKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CkwpB2bs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CkwpB2bs"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G4kCmC1693542;
	Mon, 16 Feb 2026 12:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bBo3PMdz53p6HXP85
	roSVd3An23eLxmaRub3fQiatvs=; b=CkwpB2bsBA3HOMN9g+Ug1kWzjoRrff5+5
	tKeAUdZiZAxBqjQ30gTchrSlXRp7ckpNLBjQKOSVehLv0G4VoRUHwtDCd94nx0ml
	HF5HLlNYavsuQqVjs2yUdgogtCSHCa+bpczGmxtRxozSEmoKPySqUwmOhJOMgsS1
	PmES5ZQw3GFqrkcER7xaFqUUyrYTTCXq8F4qRAL8axSTMpuM82gUnZpWCqB/usgo
	9HOceyG9E09zm6z2Rs7PYC1xnEt1QMl/2SjRoRegj3PUg7wSzBvGxM8e7aAO1iul
	FtZ7p7e+vOjdvHHJwCs1MfoZJu60/mo+NIhgfxWEwqX3cxTfluG/A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6ufh5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:20:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GBJ1JD025224;
	Mon, 16 Feb 2026 12:20:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb3rxndhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:20:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GCK52K50463034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 12:20:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0823E2004B;
	Mon, 16 Feb 2026 12:20:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1965F20040;
	Mon, 16 Feb 2026 12:20:01 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.220.239])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 12:20:00 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH v2 1/2] cpuhp: Optimize SMT switch operation by batching lock acquisition
Date: Mon, 16 Feb 2026 17:49:28 +0530
Message-ID: <20260216121927.489062-4-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216121927.489062-2-vishalc@linux.ibm.com>
References: <20260216121927.489062-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=69930b7a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8
 a=KN9s3eCRc324pKJoVuoA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwMyBTYWx0ZWRfXxDxvC9R1N3Xy
 Bhf6VGrD5Nmlk94ov1Li5N7W6YBMKQeB/fmwwuWag0Aqni/cP56zXdEqfcJMHFNp41GrMZFPjpv
 nxOHzn9IX4OX9bSvpz8rfCx/iZjl2OF5ClwYdPsmqzVF7LlS+HV2jOLfyVhQS18At6Exouz+kAF
 rI6Nbi56TYDSm+JDF02UHTm2YEolfS70cplVHrU9MvvM3f0X4D445evvFTzIZxIrmO8Ugqv4NtX
 hjWo8bDMU9swOR05YxqpcvD+TJKEwf3bThBj2oxEvV83/BtWDpyPEmYO7IGyZgrU7NlCY+QIYxK
 UPMeTO6wK3iyaG/9heHxrlk+B0P54WreQOQkpUUxpRD4e4RxuO4fJ2NFC9Bqib4H3U9lciv96c1
 S/KOQiebgLwlrNdTaFmaK4euM+q9S8J4p+XOhx1zCBnHCuuD+S0FxYFvp/VJJZho6zX50uphsxY
 val7/n0ehLItrvvvw7A==
X-Proofpoint-ORIG-GUID: y7xrOflilL9oUfdUQvqCddqTiUef2uth
X-Proofpoint-GUID: Pr0w0x6UzmPJvGdqrLgnzsMbQgiicx7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160103

Bulk CPU hotplug operations, such as an SMT switch operation, requires
hotplugging multiple CPUs. The current implementation takes
cpus_write_lock() for each individual CPU, causing multiple slow grace
period requests.

Introduce cpu_up_locked() and cpu_down_locked() that assume the caller
already holds cpus_write_lock(). The cpuhp_smt_enable() and
cpuhp_smt_disable() functions are updated to hold the lock once around
the entire loop, rather than for each individual CPU.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 kernel/cpu.c | 73 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 01968a5c4a16..edaa37419036 100644
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
@@ -1464,8 +1463,17 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
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
+
+	cpus_write_lock();
+	ret = cpu_down_locked(cpu, tasks_frozen, target);
 	cpus_write_unlock();
 	arch_smt_update();
 	return ret;
@@ -1613,18 +1621,18 @@ void cpuhp_online_idle(enum cpuhp_state state)
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
@@ -1632,14 +1640,13 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
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
@@ -1663,7 +1670,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 		 * return the error code..
 		 */
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/*
@@ -1673,7 +1680,16 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
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
@@ -2659,6 +2675,16 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
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
@@ -2668,7 +2694,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		 */
 		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
 			continue;
-		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
+		ret = cpu_down_locked(cpu, 0, CPUHP_OFFLINE);
 		if (ret)
 			break;
 		/*
@@ -2688,6 +2714,9 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	}
 	if (!ret)
 		cpu_smt_control = ctrlval;
+	cpus_write_unlock();
+	arch_smt_update();
+out:
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2705,6 +2734,8 @@ int cpuhp_smt_enable(void)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	/* Hold cpus_write_lock() for entire batch operation. */
+	cpus_write_lock();
 	cpu_smt_control = CPU_SMT_ENABLED;
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
@@ -2712,12 +2743,14 @@ int cpuhp_smt_enable(void)
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

