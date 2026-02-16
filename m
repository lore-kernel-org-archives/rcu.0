Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D92D0C9C;
	Mon, 16 Feb 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244436; cv=none; b=gqvup5f/kKTZvBppjx4+o0XMMpdtJpbmotSlg//sQXtnit211JIrA+9SBC4nmPSFBpXt3ntPWif8RzmoL/AQY9ksssn/UTuaU1sZoRklh4uhb8YRLboHIXmrmoI5Na8YLZKBT83/e6dMvZH4Oy9rOJNbDtSU+qXIC/q8f+av0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244436; c=relaxed/simple;
	bh=QUlArS1PvREJtB73nK99k/+uhCSr+QIYrcpwlvOlhzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8y8u1dOXuJbJW7fg9WK/L35Jr+xBjKU67kVX3tpiPFmxbMzC7MuS/3H7oP02YDtsdeR7TCKt85gM6RJyjB+IkmZFjptk+v+Fv1/ppGj5/qi3gcf/kIq0IumHCdMdjWo8MxgWDa+m3NHF7rfNBxgohyWU8kyHM7OxK8mjDoSFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AD71OmgX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AD71OmgX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FJsALR3436479;
	Mon, 16 Feb 2026 12:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Gw8lzl0IOSPLNR1sh
	uSRN0DyJJbx7KxlCd96hl1idpY=; b=AD71OmgXpWZ2c2SfKuEsgloHmmkqyoC7M
	iy5ycnN2CTwJ7PvAgn9xyT9xSIoCX6ZZSL2M0eBJYFoBNnyGlV9WQEjVvv2kOZHD
	hEo+Pw9pfW63CNcXfd+vsH36V1mf6StpHtbJgyken7CNA/XHVuZBoBqDXs5HhqYG
	FxILGv/RxRa8ZUZxGO0jKiplIT7A5OIRhzszpdEibDlBQIve3V6UAZ61gdDgc/E6
	2hVk5/Ac5TmUW/lACEJIAo7n6q0BWJpmpz2n7XBhCg8Orok7nvifDrxkwpS24mfh
	Wvhq3DPk/goOsZDQ/GnwpaR1ISfBbQWnxmm6kx1fRQ0ohysLlrZVw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj7354-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:20:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GCHMYu032483;
	Mon, 16 Feb 2026 12:20:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4vjw82m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:20:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GCKHvW58720578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 12:20:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 428672004B;
	Mon, 16 Feb 2026 12:20:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECBE120040;
	Mon, 16 Feb 2026 12:20:11 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.220.239])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 12:20:11 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH v2 2/2] cpuhp: Expedite RCU grace periods during SMT operations
Date: Mon, 16 Feb 2026 17:49:30 +0530
Message-ID: <20260216121927.489062-6-vishalc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: O35YA_QkrtAgHi-SE6NXwCTLz6Usq1B8
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=69930b86 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=l3qGZ9BfJl2m4va5N0YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwMyBTYWx0ZWRfX2w7qLQENPDLL
 cMFgC89eFTT/BqrO77b7xx94Nm+yk1sFg32dAqeZYicUWRJwDCXV/6eZkTWX/wrhvdD2zOSlnHy
 hRFxxjdtGkN67z3gbeKFFRESe18dfstfnelv2rOMjw0KWwr8gPRqQVONa32kAFmqtVrvrCnozKz
 ttBWzQbvbGJUAbnYbMt2Ljn+qUf2fhiouVSffybiTjptvZkFW0Jfs/8yOFqqv61W/z1wUpWLa48
 YYIGQNRGq9zDmkRtv3mFiDPrYGdw1Gb3SncxCNkHGA3Fy+AVciUp4TORYWbHZumfUCrDaDJ91A6
 7o3LtztOQHrz8g+3tTdwZc3fus2rUgrYHuaDznESIoD5tmK0YX2F82R3/kb9iXCTrB4CEm9DEUJ
 HUIXGkKzDKtgVpr/KtAZilG+u+/r/6vV3O/5eqN5ukfasFcsz/cqvtQrpsPwOYGu7LULQwcNQ/+
 2BsMr4KAb/NvPvg0QNw==
X-Proofpoint-GUID: dJXJNAGr0HSLnKLWPHEP19TDxXPkjJ4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160103

Expedite synchronize_rcu during the SMT mode switch operation when
initiated via /sys/devices/system/cpu/smt/control interface

SMT mode switch operation i.e. between SMT 8 to SMT 1 or vice versa and
others, are user driven operations and therefore should complete as soon
as possible. Switching SMT states involves iterating over a list of CPUs
and performing hotplug operations. It was found these transitions took
significantly large amount of time to complete particularly on
high-core-count systems because system was blocked on synchronize_rcu
calls.

Below is one of the call-stacks that accounted for most of the blocking
time overhead as reported by offcputime bcc script for CPU offline
operation,

    finish_task_switch
    __schedule
    schedule
    schedule_timeout
    wait_for_completion
    __wait_rcu_gp
    synchronize_rcu
    cpuidle_uninstall_idle_handler
    powernv_cpuidle_cpu_dead
    cpuhp_invoke_callback
    __cpuhp_invoke_callback_range
    _cpu_down
    cpu_device_down
    cpu_subsys_offline
    device_offline
    online_store
    dev_attr_store
    sysfs_kf_write
    kernfs_fop_write_iter
    vfs_write
    ksys_write
    system_call_exception
    system_call_common
   -                bash (29705)
        5771569  ------------------------>  Duration (us)

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 include/linux/rcupdate.h | 3 +++
 kernel/cpu.c             | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 7729fef249e1..f12d0d0f008d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1190,6 +1190,9 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
+extern void rcu_expedite_gp(void);
+extern void rcu_unexpedite_gp(void);
+
 DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
 DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index edaa37419036..f5517d64d3f3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2683,6 +2683,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		ret = -EBUSY;
 		goto out;
 	}
+	rcu_expedite_gp();
 	/* Hold cpus_write_lock() for entire batch operation. */
 	cpus_write_lock();
 	for_each_online_cpu(cpu) {
@@ -2715,6 +2716,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	if (!ret)
 		cpu_smt_control = ctrlval;
 	cpus_write_unlock();
+	rcu_unexpedite_gp();
 	arch_smt_update();
 out:
 	cpu_maps_update_done();
@@ -2734,6 +2736,7 @@ int cpuhp_smt_enable(void)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_expedite_gp();
 	/* Hold cpus_write_lock() for entire batch operation. */
 	cpus_write_lock();
 	cpu_smt_control = CPU_SMT_ENABLED;
@@ -2750,6 +2753,7 @@ int cpuhp_smt_enable(void)
 		cpuhp_online_cpu_device(cpu);
 	}
 	cpus_write_unlock();
+	rcu_unexpedite_gp();
 	arch_smt_update();
 	cpu_maps_update_done();
 	return ret;
-- 
2.53.0

