Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AB214A95;
	Thu,  6 Feb 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836911; cv=none; b=IUXLyR/gpn4WbqbVOzCTvYG/0ibSr9ugcc+r4me1jyeTBffpQmSVsmxnFSXBfHeDFSi7sSZR0ccXlLgTOBFrv57A2TucbCDr6WWGj7EemWGkZUkV0wfoyKsYTO9dh/m6jQDjNB0dil43z2kk+RjYrhp8kyu3mRKn7vPlE0sLQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836911; c=relaxed/simple;
	bh=VG5HSHinGwYbVMpv2rQoOJ5GIadUMJ807SdOz+nKolY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jgj2jXyCea1O52LVEzDsOEWL+sE7npvpCEGGvtKhcJa2ENXL1QmylFmYpIYjIJQH32a0YF+TpNeHiLKWC97LgEUBlZg91clDFdgXGnnZEr290JJMAapYURuWJ0lAcPnjXXyX21ROvD5+AFZ16omtHdwkI3rvVwnoPhdtHgQM4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVQ8L++7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVQ8L++7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D1FC4CEDD;
	Thu,  6 Feb 2025 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738836910;
	bh=VG5HSHinGwYbVMpv2rQoOJ5GIadUMJ807SdOz+nKolY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lVQ8L++7Zvk75gXGftG4dn6oirX8L1BVfGsyYr/MtJ1+xNjeGoDW2Lhf/9+BK7eYM
	 hmvDoeR5qWrUStzzWsiNMBu4iIf1ruI6abOfAXBAmHenvcqBTXWjBoa25ipUrLwTBF
	 MQCdcgqJrHyxg/wvBGx2l3JWbwUOx5USE5B8+OQWYQ1AJ9rBYnUCYvDYiNfsos5Kcw
	 x31tuvlg0c9cbY7v8S2SwpgMrKHmK5TSBLxF61oNur4WhEKrvVjPSl8er24KI2+nmV
	 yOBJj9507ol+6A3yCx61mOd16AP++vCD3hrpLyPpIENomCqdxoatSCduHdtkKPDXE3
	 nJWsrO/gV3wrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 03193CE0B74; Thu,  6 Feb 2025 02:15:10 -0800 (PST)
Date: Thu, 6 Feb 2025 02:15:09 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	leitao@debian.org, vschneid@redhat.com, frederic@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH rcu 6/5] Make RCU watch ct_kernel_exit_state() warning
Message-ID: <bd911cd9-1fe9-447c-85e0-ea811a1dc896@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
 <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>

The WARN_ON_ONCE() in ct_kernel_exit_state() follows the call to
ct_state_inc(), which means that RCU is not watching this WARN_ON_ONCE().
This can (and does) result in extraneous lockdep warnings when this
WARN_ON_ONCE() triggers.  These extraneous warnings are the opposite
of helpful.

Therefore, invert the WARN_ON_ONCE() condition and move it before the
call to ct_state_inc().  This does mean that the ct_state_inc() return
value can no longer be used in the WARN_ON_ONCE() condition, so discard
this return value and instead use a call to rcu_is_watching_curr_cpu().
This call is executed only in CONFIG_RCU_EQS_DEBUG=y kernels, so there
is no added overhead in production use.

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 938c48952d26..fb5be6e9b423 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -80,17 +80,16 @@ static __always_inline void rcu_task_trace_heavyweight_exit(void)
  */
 static noinstr void ct_kernel_exit_state(int offset)
 {
-	int seq;
-
 	/*
 	 * CPUs seeing atomic_add_return() must see prior RCU read-side
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
 	rcu_task_trace_heavyweight_enter();  // Before CT state update!
-	seq = ct_state_inc(offset);
-	// RCU is no longer watching.  Better be in extended quiescent state!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
+	// RCU is still watching.  Better not be in extended quiescent state!
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !rcu_is_watching_curr_cpu());
+	(void)ct_state_inc(offset);
+	// RCU is no longer watching.
 }
 
 /*
