Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CEB3033CC;
	Mon, 15 Jun 2026 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497584; cv=none; b=Zp0DcXYDs8cmwfQDe2kdPZ9RP49wf+1HR5oWs1mCjgDsaRhmrDt1lnb79y4kRV87s8SwTeZ6cgq7V3RZJTzoK6XG4sW8Z8X+Qy6tHhRqesincmTLd75vAwWxRV9mFRuUMJ1gFXc45e+oxkSswB3lXa1dGjsAodx0PsbpvdijYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497584; c=relaxed/simple;
	bh=qyb0rpK91jdM/q3D8bA6vOLHLp6YI66tdPxOViHSlLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsHEoohNbCGTVqxrHSUt8RiSDDd9JyKW+/KMIPmIAqj8ZSjbazoJdFdWtzkvM7fcp3jUcoHpZga72XbUNlGBdTGVPvvO2KutBCe3NtJCwP+cIQ1FQajz3OgyiMzkrq15R27LtXQyJujl0KnlV8z6jXAKX3/YR/gThpVBzJoyXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dYVjMk+5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dYVjMk+5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1mZNY932346;
	Mon, 15 Jun 2026 04:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y/Zjbbfms1TKQ2KOG
	Tynl3/nz/jkx44N0DlQyQKG0W8=; b=dYVjMk+5B25ul4RtjjbaMZWuhCe5A6fZJ
	YjaKPz482F6SmmMCGr+qVlG4Wr1M+LaWgmO/nU7VuoIcMla3A4fitpytMgZdk+9V
	EijQ4N3rVrRO8XQtZGFycqz+8bsf4NyHAwzaOitjrBksKt7y3kVuPxvZ5wTeAi1g
	VJCLeZeQlyru3x5GVxyOoqsPkpPvd5jHQs9SgV1CTZpNXrT/wNOVJRXyTdvIPPQ3
	tY1aX9Za45h50ey4XDojmFwIoDEzZmESCCMz+Cm7yo6xixTlKad5+rGG5P3Uw/bU
	z6/cf+/Qp/U44qFCK5vVFOIh67E6TfkRn9fK8/9y9id57ctT3lVqw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkxs14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 04:26:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F4JlEY032634;
	Mon, 15 Jun 2026 04:26:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpw3q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 04:26:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F4PwNc28836520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 04:25:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 191332004D;
	Mon, 15 Jun 2026 04:25:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 465A22004B;
	Mon, 15 Jun 2026 04:25:52 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.215.27])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 04:25:51 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, aboorvad@linux.ibm.com
Cc: peterz@infradead.org, boqun.feng@gmail.com, frederic@kernel.org,
        joelagnelf@nvidia.com, josh@joshtriplett.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
        srikar@linux.ibm.com, sshegde@linux.ibm.com, tglx@linutronix.de,
        urezki@gmail.com, samir@linux.ibm.com, vishalc@linux.ibm.com
Subject: [PATCH v5 1/1] cpuhp: Expedite RCU when toggling system-wide SMT mode
Date: Mon, 15 Jun 2026 09:55:16 +0530
Message-ID: <20260615042514.694993-4-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615042514.694993-2-vishalc@linux.ibm.com>
References: <20260615042514.694993-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA0MSBTYWx0ZWRfX6sVmT8VjQHFR
 aPRmQQoj0j9sf9l2v/ksFMwVuNpRNfMCH/4GGfpB4PJaOES8e2N0GkfMRZ2PQo/cEf9+usqjqGg
 x6HdTKUGVPWG1tqvkh6tgGLA3etf3lA=
X-Proofpoint-GUID: DsFISiI4UpEFnqVVOSAJlE-GQyQm5PpR
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2f7edb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=qlJoO9hcsj7EdhmLNQwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA0MSBTYWx0ZWRfXzOXTvigrLWua
 DvY+S8JwuMDE4uFAnb9W/harj+Bol7PLO5P71rvJD8BLG3tqlr2d54rGF+AZtCDqVxNvrkrCrcm
 8WO8tG4Jkw8u3PUO1yHRG/Xwu0muftF9Y9FcMwR58vOw7MhzOSBJnIi2uQ7SdjvotHJvfHozzQe
 E2pYHYnwV3PFoMAyAwWFuEHYC+aXNblUkEwVzQtRj2RpQn905tIM0GLwXISTbhmaCMKI/TKomNF
 u5Bm9Jxgr/nBTPSlPs/YRcVH125cNmqzhsb6mx4SdpdZxrQvTA9YBmSIspL2ZExaL7Lwy1bRYQD
 qWL7IawWqJPjQKR+tDs30dE62yfsnGcakyZfvZ6nAOW2U9x3x9lTr+iTkU5J2CxJOSHY013kUPi
 p7XlkAOAMCkMh4h2vYhP6aXA5/jSuV/90P0IW0ELYMduy5CJQvaEfS19s0YNfBx6bqXl6xi1vY4
 +0E8ZBga3e0TT2HC1Ow==
X-Proofpoint-ORIG-GUID: flW9rPNJq4JP3SrtxdHGoZ2Co9KgTiix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150041

On large idle systems, changing system-wide SMT level using the sysfs
control interface still takes approximately 40-55 minutes. Changing SMT
levels is an user triggered operation generally done when systems are
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

Tested-by: Samir <samir@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
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

