Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7B1714D7
	for <rcu@vger.kernel.org>; Mon, 24 Feb 2025 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372198; cv=none; b=K2qDzTH0QSCT5C8mpTf/abNcWHNO5ms2b2PVUF1l6Jiluyy95bGArK5AWLqUboKcvI1gADgx9N8bjBKOQX1DbvxtsVHkVcpx+hg7wJ3BXX5U8jMn3QQEwMeq9HvoKI4IvP40oJTbu8ZSw1WTP+B8lBFwiZn3ZSHuYZzJM729hA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372198; c=relaxed/simple;
	bh=wWzZAmRR4kWrwyMPYjkUlV/8tv0FxjZZSfATo39C9fE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpGrTfxQwHQAv82nIACHzRZquJJqAhejGgfVNnUnNSkYmqEBvJq1yWQxM4MPlirgoiSbZ8dAyjpU//Yult8JiEgl1PPEe8K3erHpWn1Tl7c1e5Qc6287tspHtgbMBep8Q5WvBZQX0PvvYXmU2UzzBDQTdmWR05KXvWNYQtI+Vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POSbj3Yq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POSbj3Yq"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471fe5e0a80so34767291cf.1
        for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 20:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740372194; x=1740976994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TCu7u98k6eSO2x3h8Jk7eAX/GSVZfduiAYOujt8ShbY=;
        b=POSbj3Yqr8yT/COb4dBg67Grp3SHpBARuweNlSq5PK006weagCpvZ3zB3FwTteYYRI
         eRI1DPJ75LW9m8qN+RdVSJ240IODLvnuLFn/Ayw578pNCFqI/dERh8VWKNnb/ouVrWXB
         QN2WQ7CciMDbGt6zQSy8iTqK5OroD0oibewo0vfRdcsrxUW6jTjvleaTbHO89yEP8mFi
         b0ob+Ml/SiR5rDJupYBPwOj/rsswQfo5I6QpX/4Qg+2O+Hs6czPj3Nn6WGsJlTwJYp5X
         pVLcO9XEmcHg7ikXJag8+J9M9Gsdcm8mCckl2Fsylm3qpzYHrpA/hZhorH6SEbQ3bHbO
         FXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740372194; x=1740976994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCu7u98k6eSO2x3h8Jk7eAX/GSVZfduiAYOujt8ShbY=;
        b=W9/SQUK+ZyF4/l7Z/gGJJHaef77trNLuafok3moKvF7Wr/vpJN8zhTqAZWiVMQl0Mw
         AhlywjhtlRWX0SkQNMx6+AoltQIPiSjYseo3Ewktmqql/i7XlGbIZrpAdvzOFFd35ShU
         BfViyfs2T7vjOci3tiIYYl2izV3MKzV9guUvra+nkbGaMVjp2Hc2VH6CcDV4Npgb+uwZ
         /BErbINcJTxtq+yOkL+DHDrafK6jRmDTl/6doGoltua6KUMG5eq360IVHE1MkYvQ84QY
         S5jaYvcHo1GmVqqodkCWzIozn2nuWcPU4jIfOfVDJtGSQU9ggEr7gw02ajH5d9+VEhrB
         l6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUkkULkqfog9wtjkA1mQ1cxIr907B2tXuxcUW0cqlidm7UPEx0VSr63gWyO1bw+4BlysBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZn577Eqjtz5dYFb4D1Img70jMBXtk3ofbgABnsSJs9k2V6Eq
	wBM+Briy2TVtwIBm8Cxn/FyRuz/MGkUb+QH+51rOv+fXYojzJQPG
X-Gm-Gg: ASbGnct8gtROjUTpPcsDsDz9bMvaStQniFfpuPFjTbuLmQz2C9QW2lR7//yfHMBn3OM
	7lxY9wG40ljZ+JwIz29gt8Ht7XBNEqIoBg5bP4a5Y7XiOsazjRSWjFByDrhJj8uZvRI25gMKVPe
	Pxk5/zhEy0vw0LQhGDY9g5rKv/hG38F/fDeHpVixhjKL0kbXxU3qLxuXZ5wZSLeFPRHH6uL5Y0v
	OAvPmnpkQS6l+tag/7Qni/rtDRt0L5tb5t3o6zzHnDYk7mczoJd6MUEIGuTTCzGTn9ZcciIyDd+
	asAIjye3pbDKp1MGd702RVDPLOFEF9qTCjlj0ipf4Feb3LVwiOQwYc50mEPfiayvm/gS/i+hYH9
	t3ugAoc5dg/UnbaVQ
X-Google-Smtp-Source: AGHT+IHuLivU+/6K+5NgpAn4ukWUm2u3d7P3jIpzJlCVSJmjVBGKc/zkgBvjgALEBM8NXY8R8hsp4A==
X-Received: by 2002:ac8:5a04:0:b0:472:58b:463d with SMTP id d75a77b69052e-47224716682mr159802281cf.5.1740372194078;
        Sun, 23 Feb 2025 20:43:14 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f33415e5sm88185561cf.41.2025.02.23.20.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 20:43:13 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2C6D3120006A;
	Sun, 23 Feb 2025 23:43:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 23 Feb 2025 23:43:13 -0500
X-ME-Sender: <xms:4fi7Z7sw_N3Xs1MC51S63Ug0hzXE5Rs6Xv1Xs4AU6duB8RNuVG0nCQ>
    <xme:4fi7Z8fdgnbwsO-1sU3lze8aeSxzKhzx66hMj1UXoNXrKqm1lyyKbmG1KyIvtb6sN
    oVRXK46muYrNnNtbA>
X-ME-Received: <xmr:4fi7Z-yPzQWYhkNDpVBMiy9qXMBvH0M2Qzsn9U6UwTBKxRUa8AJ6TR3z4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeu
    heelhfeivdegffejgfetuefgheeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopeholhhivhgvrhdrshgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepphgruhhl
    mhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnkhhurhdrrgdrrghrohhrrg
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohgvqdhlkhhpsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehfrhgvuggvrhhi
    tgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4fi7Z6O7R8ImAhyOSJOcH7PKonGqoMVSlE2CbiCdQ5dFsp3YHfn8lg>
    <xmx:4fi7Z78ap7vWDwEfeLGLQ39przRAEflmndmdgk6crVrYkk96P2PCLA>
    <xmx:4fi7Z6WZKNOm_i6XWFK4Rn35Oka0el7xx684sMh7Ie8TNM32Rg81PQ>
    <xmx:4fi7Z8c6DY_tZzVf-PUZt3hEgyp961o3Hh_6fnBqqMCnzRWNYlIBEA>
    <xmx:4fi7Z5edlZWmvzyqoDVfXNQRa8b5RJzyL7ZXZ-q8T5mPCd9tGsNi01ma>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 23:43:12 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	rcu@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2 1/2] rcutorture: Update rcutorture_one_extend_check() for lazy preemption
Date: Sun, 23 Feb 2025 20:43:09 -0800
Message-Id: <20250224044310.14373-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <Z7v4MytjhhBZkG4S@Mac.home>
References: <Z7v4MytjhhBZkG4S@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcutorture_one_extend_check() function's last check assumes that
if cur_ops->readlock_nesting() returns greater than zero, either the
RCUTORTURE_RDR_RCU_1 or the RCUTORTURE_RDR_RCU_2 bit must be set, that
is, there must be at least one rcu_read_lock() in effect.

This works for preemptible RCU and for non-preemptible RCU running in
a non-preemptible kernel.  But it fails for non-preemptible RCU running
in a preemptible kernel because then RCU's cur_ops->readlock_nesting()
function, which is rcu_torture_readlock_nesting(), will return
the PREEMPT_MASK mask bits from preempt_count().  The result will
be greater than zero if preemption is disabled, including by the
RCUTORTURE_RDR_PREEMPT and RCUTORTURE_RDR_SCHED bits.

This commit therefore adjusts this check to take into account the case
fo non-preemptible RCU running in a preemptible kernel.

[boqun: Fix the if condition and add comment]

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..280bff706017 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1873,6 +1873,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
 static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
 {
+	int mask;
+
 	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
 		return;
 
@@ -1902,8 +1904,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 	WARN_ONCE(cur_ops->extendables &&
 		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
 		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
-	WARN_ONCE(cur_ops->readlock_nesting &&
-		  !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
+
+	/*
+	 * non-preemptible RCU in a preemptible kernel uses "preempt_count() &
+	 * PREEMPT_MASK" as ->readlock_nesting().
+	 */
+	mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
+		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+
+	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
 		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
 }
 
-- 
2.39.5 (Apple Git-154)

