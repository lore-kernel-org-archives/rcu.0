Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259032C94A;
	Thu,  7 May 2026 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132454; cv=none; b=iCOzNehz09x31VBb499A90fHUgX2ocIScXX9hDQnfIP7VteVbBM+v0Id8/QNe+pXPwkOUElscCvXsjqySaFQaIo/gdT5+imID8LewLnBF3aB+0atA1CJ83WK4IBA9Ku6ML6sVCO8aJSoyERVaDAPZs3l+h2esWUx16uvFQbfnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132454; c=relaxed/simple;
	bh=QGvF5yj+/xEfNukokaYlCu+V/qA5yAPtXSLZQLXcTdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6N6fGHAnYrt+o/Ra0yXVPz58MRgqSzMruRkpEk/ZbsAwV81jbR/W7NxGVIOimWTnYjEaEYmFbeXcS8qCOfiRceRJpM7wVm/mufdzYX1P8jZ24WERKPPBqQNJtJFgPcx7TEbrwhEkK9BespuOKsRJ7F/s7iFwfl22TjhNhyLlzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BpC71n0R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BpC71n0R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6473btlj535863;
	Thu, 7 May 2026 05:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4SRUwjF6dQ6cBne9u
	FxdyrvAWOS0AEWqj0hNXXFcsJ0=; b=BpC71n0RZ8baLC2jMDqsNpuVsFpYS2tgV
	m6jU9/bXG4DpteaE7Krn9LxJe13z1qrXQJAeWjXEFIp1vQzcyQYu0Og41Qd1ufQn
	icOhCTp+wm3h7HbIbqlBDK2nT8yFVAUkPDPHIpQ1Azi++zfTH+Q9/KBYgWzKEqDG
	vWIMFc/hWS+2AXTnLTyjGXEqM9c8/s9QdQ/AbFksOl3Q0YsJImSirga4dmwmkqG2
	2dUfl1VLhRPdtbQw5OcCjHe+SNVXcH1qB0SNYzib8UpNERcyHcY8X24khE68M0Y4
	hXgZrdg/MB4WNIIij2llkcuJB4eUgbCU6zYoRRspJC7V6VnW7s9fg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6kf60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:40:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6475dPlM011182;
	Thu, 7 May 2026 05:40:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk1kqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:40:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6475e88r62325150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 05:40:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4FE620040;
	Thu,  7 May 2026 05:40:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAAB12004D;
	Thu,  7 May 2026 05:40:04 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 05:40:04 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH v4 1/1] cpuhp: Expedite RCU when toggling system-wide SMT mode
Date: Thu,  7 May 2026 11:09:29 +0530
Message-ID: <20260507053928.2975867-4-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507053928.2975867-2-vishalc@linux.ibm.com>
References: <20260507053928.2975867-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fc25bd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=qlJoO9hcsj7EdhmLNQwA:9
X-Proofpoint-ORIG-GUID: _1CnsaXbKGury2NyJxxedzeqhVkPNMhA
X-Proofpoint-GUID: XEJIGJmBEu2SxXmhGDMYRWuvmRdE-6Ii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA1MiBTYWx0ZWRfX9QPJ9t74F1XP
 dGvxUE2m+bstEAxjtZoNpH4KYIeSeJ38LNhUZLUfl+jxw0GvkkqQAzpkqv+YcAEoRTx8l7CiI7R
 tZmRcQLO4I6/tSLCI3MF48YvqEVoFzZP0YlNBIGTLQFj+Gu16qriUFNmgJq4ILe4ajQq0GMYJJE
 FXYpf8P322K2CupO3thyQTamwrxpxP2WJ6+VTRFTTrcnKEW7jmMdRgU28jMWdvKu8Pq8uOO8ALQ
 LToxJKqghMYJAXYs3ZTPTB+w7IAM54ZsfIfUL4coRJGBQxo3nDd8/ehSl7neHAs+Grp2UmQZ9/n
 4cTWILHJLzCFO/EmnE6McQkEcKZMK9U2bP0syTASjlE9yxEup+viD+E0XVi2ulRZIwcwJ9mUvIx
 w9TMaMdx0SxS89N7Ai1Hym2PCxRjIoUS5vQE3rnxg8zxKaLQwmAi6aKDqvew8hxvqemVlRY81S7
 jW47vcCqQMOFPj9AosQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070052

On large idle systems, changing system-wide SMT level using the sysfs
control interface still takes approximately 40-55 minutes. Changing SMT
levels is a user triggered operation generally done when systems are
fairly idle. This causes users to be blocked from doing other subsequent
work.

Analyzing the collected profile data during SMT level switch, showed
that CPU hotplug machinery was blocked on synchronize_rcu() calls.

Expedite RCU grace periods for the entire duration of triggered SMT
switch operation via the sysfs control interface. Individual CPU hotplug
operations via the online/offline interface are not affected.

On a PPC64 system with 400 CPUs:

  SMT8 to SMT1:
    before:  1m14s
    after:   3.2s   (~23x faster)

  SMT1 to SMT8:
    before:  2m27s
    after:   2.5s   (~58x faster)

On a large config system with 1920 CPUs, completion time improves from
~1 hour to 5-6 minutes.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 include/linux/rcupdate.h | 8 ++++++++
 kernel/cpu.c             | 4 ++++
 kernel/rcu/rcu.h         | 4 ----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bfa765132de8..b6bccf131f1c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1178,6 +1178,14 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
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
index bc4f7a9ba64e..6351da9dffdc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2658,6 +2658,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_expedite_gp();
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
@@ -2687,6 +2688,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	}
 	if (!ret)
 		cpu_smt_control = ctrlval;
+	rcu_unexpedite_gp();
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2704,6 +2706,7 @@ int cpuhp_smt_enable(void)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_expedite_gp();
 	cpu_smt_control = CPU_SMT_ENABLED;
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
@@ -2717,6 +2720,7 @@ int cpuhp_smt_enable(void)
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	rcu_unexpedite_gp();
 	cpu_maps_update_done();
 	return ret;
 }
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1..d6a63ee60bc0 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -521,8 +521,6 @@ do {									\
 static inline bool rcu_gp_is_normal(void) { return true; }
 static inline bool rcu_gp_is_expedited(void) { return false; }
 static inline bool rcu_async_should_hurry(void) { return false; }
-static inline void rcu_expedite_gp(void) { }
-static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_async_hurry(void) { }
 static inline void rcu_async_relax(void) { }
 static inline bool rcu_cpu_online(int cpu) { return true; }
@@ -530,8 +528,6 @@ static inline bool rcu_cpu_online(int cpu) { return true; }
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 bool rcu_async_should_hurry(void);  /* Internal RCU use. */
-void rcu_expedite_gp(void);
-void rcu_unexpedite_gp(void);
 void rcu_async_hurry(void);
 void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
-- 
2.54.0

