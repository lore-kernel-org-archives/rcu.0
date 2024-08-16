Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D64770E5;
	Fri, 16 Aug 2024 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781195; cv=none; b=TifAFhtSFdErSKLDu2QZNUKYDDK8cV/FApSI9yM1+atGZ3P7Sq0869mTCepNKQkpe//Rcfq7cs/t1eJ4UuCobOGFVq56FBuDVBPVr/zzBXstT48nrZU+sXxYN28cErVPhh8xgT6d4El+1SV4Zpo0lVCvNYIeW7d3D2nxKXQ2JlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781195; c=relaxed/simple;
	bh=jrkMkNE9TDHxapA8A5E3kTJWW0PhzMSOdacp5FUaQG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D18Dnr6IUlg2oG72Ig1J2glW8wHlTlUsdXDjdz0IGEGn1Z7qdsdsXk2BTpUVgx2eatCrtBJKLVTH23162jpeVNAwi0YWrn1sDXAdLmnSotfz7GH1pSwA0Msb1xdifp4stl9puwTEJ10sx0xqWEbT1ohg+PrEXtgQPDUeazxRe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVafHjHk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVafHjHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C113DC4AF17;
	Fri, 16 Aug 2024 04:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781195;
	bh=jrkMkNE9TDHxapA8A5E3kTJWW0PhzMSOdacp5FUaQG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVafHjHksmZRa3uu1DsC3DJLqr2+aGhDVEeORS4r8r2j9qRQzmcRw8T93annbTZIa
	 GSBlcOzBJJ/r087eIxzJtR+8ixwKHG8t/JM9FvL1Rd1swiKkAQPs8BsZVgGAsesnNb
	 yQ3f46qGfBJmB2+1HqABZnWZU/PGzuZ/Jki/SIDx9ntV7oc+s4dImoF8eMn8NIsSEV
	 6hbISrRUJ59l+sf2lEto3I+98WOqz3PGNFclSipxT/3bQ12mEeEWE5C9PMIIgNMbtO
	 rfC4LcBNbIRhU7GfabKittFU9pZwSmfMbFIAlAkEYjyxouxXb4P2MGUu8NONJE97Rf
	 SWkqhXNH41Jng==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 24/26] rcu: Update stray documentation references to rcu_dynticks_eqs_{enter, exit}()
Date: Fri, 16 Aug 2024 09:32:39 +0530
Message-Id: <20240816040241.17776-24-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

rcu_dynticks_eqs_{enter, exit}() have been replaced by their
context-tracking counterparts since commit:

  171476775d32 ("context_tracking: Convert state to atomic_t")

Update the stray documentation references.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg  | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg   | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg       | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 7163d0def34e..1a5ff1a9f02e 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -147,8 +147,8 @@ RCU read-side critical sections preceding and following the current
 idle sojourn.
 This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
-is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
-time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
+is invoked within ``ct_kernel_exit_state()`` at idle-entry
+time and within ``ct_kernel_enter_state()`` at idle-exit time.
 The grace-period kthread invokes first ``ct_rcu_watching_cpu_acquire()``
 (preceded by a full memory barrier) and ``rcu_watching_snap_stopped_since()``
 (both of which rely on acquire semantics) to detect idle CPUs.
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index ab9707f04e66..3fbc19c48a58 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
@@ -607,7 +607,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
@@ -638,7 +638,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6-1"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index e17c3356041a..25c7acc8a4c2 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -977,7 +977,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
@@ -1008,7 +1008,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6-1"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index c43e1ec10774..d05bc7b27edb 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3107,7 +3107,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-7-5-3-27-6"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
       <text
          xml:space="preserve"
          x="3745.7725"
@@ -3138,7 +3138,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-7-5-3-27-6-1"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
       <text
          xml:space="preserve"
          x="3745.7725"
-- 
2.40.1

