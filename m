Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E717BEBF;
	Wed, 23 Jul 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261156; cv=none; b=C8FaEirzClFz257FRwD6/JGtihe68Wy+P934EHsaT9opxXam/3Qt0SvaKJ3XRZlKJ7NcbM/y32kBbsg9P6gMkWjmlNTswvFXJ8LvQ1paWuexkXH5nFAvErdT/3+06rHE8Cl4XE6upYs1IqtojcltYPgi6N+27k/YQ6PFOVvqeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261156; c=relaxed/simple;
	bh=vAtJsjTxG+CJeVGzvV2qReCB+ILeVoK0JaaIwMdS7No=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qbjJ7ljKzus7igEbz3CgRWASJwI7uoy4+lyGiPMaTHqzSIh1++DvDBIaJmPT8uWjntOX6v0yu6mFmzwVOjN9DPEILHnlTtbzasb9xCfe1fxUCJUwmWTn+E11wd/C+p8W5GORyh0N0bor8M9/5EidxEEzZ7I0SxWj7QlW8OX61Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqkd+FkJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqkd+FkJ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747c2cc3419so5147267b3a.2;
        Wed, 23 Jul 2025 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753261154; x=1753865954; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUU4cYaiPlxLljbFaCXDcO8FtF5h1/oOjYiqKFdZk6Y=;
        b=Lqkd+FkJoS8inGOLhAbb7k0qQmU593zr0JcefJZgVEeZJmmBletv8mKQKN0z7sSEFf
         wjW3XhN8sUh4rir0CrUJsRO6OB4hDTdHm6wheLQEJzNMnackF7X3iGzrkD8w14rAI/MB
         Xo8XE1l/NPVCFpbpAgjCjzEgARMFjREE6ToeMGRDwkfDN/73g3wB9q0I4Sa6i7w7ieLg
         CDRiIm3eLOIe5vcrQEdQvot2wbv8Qa8zD3Mn69AAh+Pf7PcVQt3+HXp28I/wuCbQP4le
         twiiAlx1rFAPoLJX01AQDu506oJN+Px72PdVWfEBJusXyIzY7XeJpwpUVZxtlfYO91Xd
         1QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261154; x=1753865954;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WUU4cYaiPlxLljbFaCXDcO8FtF5h1/oOjYiqKFdZk6Y=;
        b=PbJswjX4/TnZjG8ToLxqX9lGK7siVAjU/lxGfiOUTmVxKoB8LeqThoBzXW0d4YWdC9
         UtxA8FfCL/rObjqb/8HVW6ZmXenPB+MDw34E6/QpeyoTQ1cyH1IN9BrLj8mcMqmM8QuJ
         a8dWj8XBhxcWqS7fSmb8ufiffPDcA0tN9a1ZRVcgoyaBW/HCfLj5tY5lF3K95JS92zog
         C991OnzyJv9UM2QoG4h3G0j5BvGpmbhb5JtVJrsPD1W7DpxRIwk34J1EiFfXAqz6kzzU
         tFLnLQ1tV8fXmzw5bKJLfboDDAxBMEGWOloBsikurkygdYscK6ILYxwIrn+jYfv4bJcX
         cQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK3qn+OaoDm2V3pKpj655w3J0Lq0A+DtSFpTIXPt6aH6Nd6aISh7aADnIBJhym8Ok+u1AR@vger.kernel.org, AJvYcCXg5UquwRmq97afNajUfCwSUmigbcMlWLW7AqpfQ6qpzoh+xZLkidONpDcJforohxFwyENL7qqdBkl5rm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8CsWIkcz89dHXI0xQUBg4hikKy8RTnnZtnNWT3yi+uKQMo+P
	aWtlqYRT+ab2OzNvTIuz+h6+J2Yvkf8uyJ+PC/zKXlr6trCupzvbMbop
X-Gm-Gg: ASbGncswlrIJ66Unn4MtKMFZXFzwI7oeUMKCwzZ2fOGxOW/HwtWE4VmzSRW55g3a6j0
	eg+87CO9KTM1txy0tTu+OJSqg8OrG+/99aRoGoTySeQzAzyf/dl16NhZSpjPcKYwvmeQcaqPiTy
	6/ozRY1KhYAM3f395KZwvqT5btLqNdpr/gsryecNANeP8y4WnnNVSq5/HTG049m+xaLEpTYPn2G
	Na+bGbd/7IwJ/g8m9EWGHJibl5z2ozaollXPn1ZQw1v2azvilfK7hmpDpYui790m/a4aWKkHDRa
	qefb9ce/pXp66olL0nLDWEeFMJYRhsSfS/qj7q/CoxMbNSoI42EPLAHkrx3rGT8XgrEnE+oY/+8
	Wlw3xHEVaT6VsplPAizKcVsSvWxcSqrhTSI2mXQLVfxnsXmZ9cXePFJp0zr6w6jXuz41y
X-Google-Smtp-Source: AGHT+IFrfEaxbIuLsef0/ZmU85kZ0DSX7AYPYnSpzIabMAiLCFE6xDlVszuPokDDqy0rz6k4ysqPwg==
X-Received: by 2002:a05:6a00:8d5:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-76034c560cemr2957482b3a.10.1753261153840;
        Wed, 23 Jul 2025 01:59:13 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155d77sm9110652b3a.78.2025.07.23.01.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:59:13 -0700 (PDT)
Message-ID: <49eb0917-6da3-4d44-8c9c-c6b376f088e8@gmail.com>
Date: Wed, 23 Jul 2025 17:59:10 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Joel Fernandes <joel@joelfernandes.org>,
 Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 paulmck@kernel.org, rcu@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>
From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -next] rcu: docs: Requirements.rst: Abide by conventions of
 kernel documentation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Here is a list of conventions applied here:

- Don't mark up function names, to be taken care of by the automarkup
  extension.  Just say func().
- Instead of ".. code-block:: none", just say "::".
- Mark inline literals by a pair of ``xxxx``.  Don't use rust doc's
  dialect of `yyyy`.
- Instead of emphasizing headings by **strong emphasis**, use sub-level
  title adornments, in this case "^^^^^^^^^^" and make them proper
  sub-sections under "Hotplug CPU".

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 52 +++++++++----------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index b0395540296b..f24b3c0b9b0d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1973,9 +1973,7 @@ code, and the FQS loop, all of which refer to or modify this bookkeeping.
 Note that grace period initialization (rcu_gp_init()) must carefully sequence
 CPU hotplug scanning with grace period state changes. For example, the
 following race could occur in rcu_gp_init() if rcu_seq_start() were to happen
-after the CPU hotplug scanning.
-
-.. code-block:: none
+after the CPU hotplug scanning::
 
    CPU0 (rcu_gp_init)                   CPU1                          CPU2
    ---------------------                ----                          ----
@@ -2008,22 +2006,22 @@ after the CPU hotplug scanning.
                                                                       kfree(r1);
                                         r2 = *r0; // USE-AFTER-FREE!
 
-By incrementing gp_seq first, CPU1's RCU read-side critical section
+By incrementing ``gp_seq`` first, CPU1's RCU read-side critical section
 is guaranteed to not be missed by CPU2.
 
-**Concurrent Quiescent State Reporting for Offline CPUs**
+Concurrent Quiescent State Reporting for Offline CPUs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 RCU must ensure that CPUs going offline report quiescent states to avoid
 blocking grace periods. This requires careful synchronization to handle
 race conditions
 
-**Race condition causing Offline CPU to hang GP**
-
-A race between CPU offlining and new GP initialization (gp_init) may occur
-because `rcu_report_qs_rnp()` in `rcutree_report_cpu_dead()` must temporarily
-release the `rcu_node` lock to wake the RCU grace-period kthread:
+Race condition causing Offline CPU to hang GP
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-.. code-block:: none
+A race between CPU offlining and new GP initialization (gp_init()) may occur
+because rcu_report_qs_rnp() in rcutree_report_cpu_dead() must temporarily
+release the ``rcu_node`` lock to wake the RCU grace-period kthread::
 
    CPU1 (going offline)                 CPU0 (GP kthread)
    --------------------                 -----------------
@@ -2044,15 +2042,14 @@ release the `rcu_node` lock to wake the RCU grace-period kthread:
        // Reacquire lock (but too late)
      rnp->qsmaskinitnext &= ~mask       // Finally clears bit
 
-Without `ofl_lock`, the new grace period includes the offline CPU and waits
+Without ``ofl_lock``, the new grace period includes the offline CPU and waits
 forever for its quiescent state causing a GP hang.
 
-**A solution with ofl_lock**
+A solution with ofl_lock
+^^^^^^^^^^^^^^^^^^^^^^^^
 
-The `ofl_lock` (offline lock) prevents `rcu_gp_init()` from running during
-the vulnerable window when `rcu_report_qs_rnp()` has released `rnp->lock`:
-
-.. code-block:: none
+The ``ofl_lock`` (offline lock) prevents rcu_gp_init() from running during
+the vulnerable window when rcu_report_qs_rnp() has released ``rnp->lock``::
 
    CPU0 (rcu_gp_init)                   CPU1 (rcutree_report_cpu_dead)
    ------------------                   ------------------------------
@@ -2065,21 +2062,20 @@ the vulnerable window when `rcu_report_qs_rnp()` has released `rnp->lock`:
        arch_spin_unlock(&ofl_lock) ---> // Now CPU1 can proceed
    }                                    // But snapshot already taken
 
-**Another race causing GP hangs in rcu_gpu_init(): Reporting QS for Now-offline CPUs**
+Another race causing GP hangs in rcu_gpu_init(): Reporting QS for Now-offline CPUs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 After the first loop takes an atomic snapshot of online CPUs, as shown above,
-the second loop in `rcu_gp_init()` detects CPUs that went offline between
-releasing `ofl_lock` and acquiring the per-node `rnp->lock`. This detection is
-crucial because:
+the second loop in rcu_gp_init() detects CPUs that went offline between
+releasing ``ofl_lock`` and acquiring the per-node ``rnp->lock``.
+This detection is crucial because:
 
 1. The CPU might have gone offline after the snapshot but before the second loop
 2. The offline CPU cannot report its own QS if it's already dead
 3. Without this detection, the grace period would wait forever for CPUs that
    are now offline.
 
-The second loop performs this detection safely:
-
-.. code-block:: none
+The second loop performs this detection safely::
 
    rcu_for_each_node_breadth_first(rnp) {
        raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -2093,10 +2089,10 @@ The second loop performs this detection safely:
    }
 
 This approach ensures atomicity: quiescent state reporting for offline CPUs
-happens either in `rcu_gp_init()` (second loop) or in `rcutree_report_cpu_dead()`,
-never both and never neither. The `rnp->lock` held throughout the sequence
-prevents races - `rcutree_report_cpu_dead()` also acquires this lock when
-clearing `qsmaskinitnext`, ensuring mutual exclusion.
+happens either in rcu_gp_init() (second loop) or in rcutree_report_cpu_dead(),
+never both and never neither. The ``rnp->lock`` held throughout the sequence
+prevents races - rcutree_report_cpu_dead() also acquires this lock when
+clearing ``qsmaskinitnext``, ensuring mutual exclusion.
 
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~

base-commit: fde3b9b1ea92135743bb0c3b0d7c426b680a5ba8
-- 
2.43.0

