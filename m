Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08A35963E
	for <rcu@vger.kernel.org>; Mon,  5 May 2025 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485084; cv=none; b=PE6D7RVhsH454l0LvUPGoZM9F0pLh2Nime66U6ZEMQ07QaBKSQCbcUlxQDehjgfpVJbxvAjpxGgRcunAVXUR3Ohn99Y5bzCQ9H+6+j9ANWeF5BRXri24ghdFFzqNxkma43iD3D3QOtN+R4u1+m/iHXXVUIE8bwraCh4WhSRryQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485084; c=relaxed/simple;
	bh=zPFcsTvnNyeAdwc6G14p2cbB498zoISsgldlU2nB6C4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ste6breigfcbUC2cJ8NrZCjwCGXsXVUt53i9s7DU1IFysmLp2K+Oqu2K3xeFaqzv88KJOAF/TsmCri/3x/GuCPGSQ1YlaDpUn5Hwdg+XrTjmFxr30VjNqGng9RjRzoOyGCg3buY8iNYgCquF0G/1i88eQF+1DfVHsi+9bRytjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIKOaes5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIKOaes5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804A0C4CEED
	for <rcu@vger.kernel.org>; Mon,  5 May 2025 22:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485083;
	bh=zPFcsTvnNyeAdwc6G14p2cbB498zoISsgldlU2nB6C4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=QIKOaes5djR6r5r2ChM0a5RmVAiqnQCP15H1X6UH4E98spZgu2quUUL7c6N9ULdHr
	 q6u/b0cfhpyTGAyJbs/idxg/brkJCBmrR7G9hKNfWeRdLWzt94NlgnaaAGBHzH6f2w
	 VfzLN2mQRLp1LZk114zLdpwJhfs1lCpE5z8VQz/AUYVsKr3nXW9HpOYKoU90dTXIRL
	 wJg4zFvEnVYBjC8xBWXn+RLBAOB/dUwbXhaDD2qCPborxptTBiiKVfiJ08/kkBksQ1
	 lC44Pn4k7DymBPWjQ8Zusop3nAGcnCV20330Pwux35Lb67GoiB2xwQVarExGuECEd+
	 TF5f1gG/X/skw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 260C7CE091E; Mon,  5 May 2025 15:44:43 -0700 (PDT)
Date: Mon, 5 May 2025 15:44:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Subject: Re: [BUG] RCU CPU stall warnings on TREE01 on arm64
Message-ID: <7e30f2f5-c2e4-4714-9a1c-879315f56865@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0250d0c7-381d-46df-bddb-729130559ba1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0250d0c7-381d-46df-bddb-729130559ba1@paulmck-laptop>

On Mon, May 05, 2025 at 12:03:10PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Following up on off-list discussions and requests for more information.
> 
> These reproduce reasonably easily, and here is an example:
> 
> ------------------------------------------------------------------------
> [  426.022056] rcu: NOCB: Cannot CB-offload online CPU 25
> [  460.867350] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  460.867980] rcu:     0-...!: (1 GPs behind) idle=8fe4/1/0x4000000000000000 softirq=2124/2125 fqs=0
> [  460.868726] rcu:     1-...!: (1 GPs behind) idle=e0ac/1/0x4000000000000000 softirq=3547/3547 fqs=0

Early returns suggest that the following patch suppresses this issue.
My guess is that the changes to TREE01 suffice, but I will try later
excluding the TREE01.boot changes.  Architecture-dependent rcutorture
scenario files, anyone?  :-/

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
index 8ae41d5f81a3..6281dbdc189f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
@@ -8,8 +8,9 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_TRACE=y
 CONFIG_HOTPLUG_CPU=y
-CONFIG_MAXSMP=y
-CONFIG_CPUMASK_OFFSTACK=y
+#CONFIG_MAXSMP=y
+CONFIG_NR_CPUS=8
+#CONFIG_CPUMASK_OFFSTACK=y
 CONFIG_RCU_NOCB_CPU=y
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_RCU_BOOST=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
index 40af3df0f397..45e3b33f12a3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
@@ -1,4 +1,4 @@
-maxcpus=8 nr_cpus=43
+maxcpus=8 nr_cpus=8
 rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
