Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7188157E91
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096697; cv=none; b=lkwTJxQsltlcAhp4iLm1FUgHze+6FpbYKN7dUotyBBffusOm5QHROl33eQB6TGnZ/EIHKOAbGdMMCLj3EGWeYL5qYa9/h4eFeBvMC3UTva/tXkpErJlA9o0hGGwz1k4JBi788LB81kim+z3/TTSfBViEqiCX9/cgMOJ2S71YL24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096697; c=relaxed/simple;
	bh=12FG3lhKungZSuRA625ghdvFAqWCd0Rf4hnvsecc48c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jdWH6nyTN7QN3rDz25mWmvl/ZlwGGG5OqynIZ+B2CX+JP/9vM50pRmg35bx9HaKS5JHGIxnP7Xm6BufIhJeomtHZoDqadZr+dfmgRvSOwTEA6IC97PekMjQTkXTjNxKjfux1txpNfjoxhuHjfs7Eb7YAFcjcOLiHEXU/L9TmGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/5c0VRm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/5c0VRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB4AC32782;
	Mon, 19 Aug 2024 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096697;
	bh=12FG3lhKungZSuRA625ghdvFAqWCd0Rf4hnvsecc48c=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=O/5c0VRmaxUMMJMTXTk6ZSYqNzWj64euoIzbL0xE2wKg4Ah/47MuKolNKeMlJgYed
	 Zw9bBAsMWbWlivp2QFgi8zbSiWuV1dC3Z6XmoCPXneviVs2EzTlUeGZbkdAOmxZyFA
	 Fyh+WzBXkTIWqiTkK2RKca7mMdPQYPPKKvML7suQbBesunkT+LvCP6tpDMLeC6GMDz
	 4souYLSmMNs0+xx1ILSqBy6ubXD4rcZ1tV6Xk0HQJaa3P4uiCehGbdUBGf6rAOwZ9n
	 1Ja2DU6jNrN7PnDUj/jUSaGIfxa7tHa9rfFV64uCK4hkKny+sNspc/rj9N8uufpyMc
	 7wXzLrwo6I75g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 08BAFCE0A05; Mon, 19 Aug 2024 12:44:57 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:44:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org
Cc: rcu@vger.kernel.org
Subject: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Frederic,

I have seen this once on Neeraj's tree with a few commits on top (-rcu
commit 46774278c74f ("rcutorture: Test start-poll primitives with
interrupts disabled").  But only the once so far.

This is the WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)) in
rcu_nocb_rdp_deoffload().

Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

[18839.499664] ------------[ cut here ]------------
[18839.500993] WARNING: CPU: 19 PID: 100 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp_deoffload+0x292/0x2a0
[18839.503545] Modules linked in:
[18839.504443] CPU: 19 UID: 0 PID: 100 Comm: rcu_nocb_toggle Not tainted 6.11.0-rc3-00459-gba3eb80edec7-dirty #1553
[18839.507190] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[18839.510002] RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
[18839.511451] Code: e9 3c ff ff ff 4c 89 e6 48 89 ef e8 98 0d e1 00 e9 3b fe ff ff 90 0f 0b 90 48 8b 83 c0 00 00 00 48 85 c0 0f 84 0b fe ff ff 90 <0f> 0b 90 e9 02 fe ff ff e8 e1 60 e0 00 90 90 90 90 90 90 90 90 90
[18839.516469] RSP: 0000:ffffa05a8049be30 EFLAGS: 00010006
[18839.517908] RAX: 0000000000000081 RBX: ffff956c5eaaf480 RCX: 0000000000000000
[18839.519849] RDX: 0000000000000001 RSI: 0000000000000287 RDI: ffff956c5eaaf5f0
[18839.521804] RBP: ffff956c5eaaf5f0 R08: 0000112269aee7fd R09: 0000000000000001
[18839.523747] R10: 00000000000020e8 R11: 0000000000000000 R12: 0000000000000292
[18839.525623] R13: 0000000000000000 R14: ffff956c5ea2f480 R15: 0000000000000001
[18839.527557] FS:  0000000000000000(0000) GS:ffff956c5eec0000(0000) knlGS:0000000000000000
[18839.529917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18839.531556] CR2: 0000000000000000 CR3: 0000000001cfa000 CR4: 00000000000006f0
[18839.533495] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[18839.535395] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[18839.537322] Call Trace:
[18839.538006]  <TASK>
[18839.538596]  ? __warn+0x7e/0x120
[18839.539491]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
[18839.540757]  ? report_bug+0x18e/0x1a0
[18839.541805]  ? handle_bug+0x3d/0x70
[18839.542837]  ? exc_invalid_op+0x18/0x70
[18839.543959]  ? asm_exc_invalid_op+0x1a/0x20
[18839.545165]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
[18839.546547]  rcu_nocb_cpu_deoffload+0x70/0xa0
[18839.547814]  rcu_nocb_toggle+0x136/0x1c0
[18839.548960]  ? __pfx_rcu_nocb_toggle+0x10/0x10
[18839.550073]  kthread+0xd1/0x100
[18839.550958]  ? __pfx_kthread+0x10/0x10
[18839.552008]  ret_from_fork+0x2f/0x50
[18839.553002]  ? __pfx_kthread+0x10/0x10
[18839.553968]  ret_from_fork_asm+0x1a/0x30
[18839.555038]  </TASK>

