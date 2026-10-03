Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFAB35C6A7;
	Sat,  3 Oct 2026 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071030; cv=none; b=OM/ucPencWGW6zjINht/lJRkdWPAKbMMZMPxtW/3FRQHc88FnJHRbjGDqI+uCLpB6Fn1w0QbtdillL4B3vhJ7BPEjSiOUatxF/d6ft9qLmuB1Qqw4i+9fDgpEVDgU881Lxt/4bldlxD7UExEyWcitp0B1x6kfrCs0B+RYnDJpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071030; c=relaxed/simple;
	bh=++jILewXeH+uM8D4Er1T0KxKekggMp2VKJnhakIgdSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLonYnfaKJY0x4WkKwbLMNFZwqht0Hd7iURmZvfrZjQO0x7Z02U1EYyToGdRngpYcpBIh87sk+KbOku6h6nXVQ6Titf9Maj7syiJG4fBU9P9CKNPJdZHYPMKIbEBUf5mA0ht3Z7XoPRWjsE8dKRu3bjkbwcN7sm7aSShbbyANsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNa2jicx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNa2jicx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D907F1F0089B;
	Sat,  3 Oct 2026 23:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791071028;
	bh=uTv9yoJbE0xTNs6DWcPqmboZIaZvOw132vaZKufaDPo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WNa2jicxV8Fh3rqNiaUWuqf9fsJpC3cU0PeFGwLfMnCNG3SNd0B6smfAejpEDYI7M
	 UZRf+dDhzFlyMniWGaUFUvMgCfmtm5sWpzTsybQBwYO26b1X3hjgGi36W3Ca25rNgj
	 VeTtr/CImItQZgwgErYW61MVHqCKaMzQQVlD0yYn0re0KLai3tkMgfVnVoj0EcQdVT
	 935MnPorCe4CWLFBFh21JQ/4+BuwQup0VXYK9Y/zhlrCqH2GBCBM3IE91fEjMqeubP
	 35yUpqkhjUQl97S5STmWfhLixQBfPRda/6YyD28JicK3AxH1cmAKDJAbP9qt1tbEDb
	 akgDDdGD+bo5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 989DECE39A4; Sat,  3 Oct 2026 16:43:48 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:43:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: kunwu.chan@gmail.com, boqun@kernel.org, dave@stgolabs.net,
	frederic@kernel.org, jiangshanlai@gmail.com, joelagnelf@nvidia.com,
	josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
	qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
	urezki@gmail.com
Subject: Re: [PATCH v2] rcuscale: add srcua scale type
Message-ID: <463c8f04-e08b-49b7-b16f-e65def841cb6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261003161720.240855-1-kunwu.chan@gmail.com>
 <A3BA2086-5718-45BB-8B3E-35C1D2CA7B63@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3BA2086-5718-45BB-8B3E-35C1D2CA7B63@mainlining.org>

On Sat, Oct 03, 2026 at 06:52:44PM +0100, Bradley Morgan wrote:
> On 3 October 2026 17:17:19 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:
> >Add support for scaling atomic SRCU grace periods using
> >srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
> >synchronize_srcu_atomic().
> >
> >Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> >Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> 
> 1: why didn't u cc me
> 2: why did you ommit my tag? I tend to review based on correctness, cuz idk pauls preferences, once I do I'll be a better rcu reviewer.

Take it easy, Bradley.

Many in the Linux kernel community consider it polite to drop a tag
from (or, as in this case, avoid adding a tag to) a patch that changed
significantly.  On the CC issue, you did find the patch the first time
without him CCing you.  ;-)

Kunwu did nothing wrong here.

							Thanx, Paul

> >---
> >Changes since v1:
> >- Rename srcu_atomic_ctlp to srcua and reuse srcu_ctlp for
> >  SRCU operations, as suggested by Paul.
> >- Reuse the existing SRCU cleanup and completed helpers by
> >  initializing srcu_ctlp in srcu_atomic_scale_init().
> >- Add .stats using srcu_scale_stats().
> >- Use "srcua" to match the existing "srcu" and "srcud" scale
> >  type names.
> >- Use synchronize_srcu_atomic() for both normal and expedited
> >  scale tests.
> >
> >v1: https://lore.kernel.org/all/20260927100359.3903688-1-kunwu.chan@gmail.com/
> >Tested with kvm.sh --torture rcuscale scale_type=srcua on x86_64 and
> >arm64, alongside gp_exp=1 and PROVE_LOCKING=y: no warnings or lockdep
> >splats.
> >---
> > kernel/rcu/rcuscale.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> > 1 file changed, 40 insertions(+), 1 deletion(-)
> >
> >diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> >index 1097ec15879c..b172882824ac 100644
> >--- a/kernel/rcu/rcuscale.c
> >+++ b/kernel/rcu/rcuscale.c
> >@@ -293,6 +293,44 @@ static struct rcu_scale_ops srcud_ops = {
> > 	.name		= "srcud"
> > };
> > 
> >+static struct srcu_struct srcua;
> >+
> >+static int srcu_scale_atomic_read_lock(void)
> >+{
> >+	return srcu_read_lock_atomic(srcu_ctlp);
> >+}
> >+
> >+static void srcu_scale_atomic_read_unlock(int idx)
> >+{
> >+	srcu_read_unlock_atomic(srcu_ctlp, idx);
> >+}
> >+
> >+static void srcu_scale_atomic_synchronize(void)
> >+{
> >+	synchronize_srcu_atomic(srcu_ctlp);
> >+}
> >+
> >+static void srcu_atomic_scale_init(void)
> >+{
> >+	srcu_ctlp = &srcua;
> >+	init_srcu_struct_atomic(srcu_ctlp);
> >+}
> >+
> >+static struct rcu_scale_ops srcua_ops = {
> >+	.ptype		= SRCU_FLAVOR,
> >+	.init		= srcu_atomic_scale_init,
> >+	.cleanup	= srcu_sync_scale_cleanup,
> >+	.readlock	= srcu_scale_atomic_read_lock,
> >+	.readunlock	= srcu_scale_atomic_read_unlock,
> >+	.get_gp_seq	= srcu_scale_completed,
> >+	.gp_diff	= rcu_seq_diff,
> >+	.exp_completed	= srcu_scale_completed,
> >+	.sync		= srcu_scale_atomic_synchronize,
> >+	.exp_sync	= srcu_scale_atomic_synchronize,
> >+	.stats		= srcu_scale_stats,
> >+	.name		= "srcua"
> >+};
> >+
> > #ifdef CONFIG_TASKS_RCU
> > 
> > /*
> >@@ -1110,7 +1148,8 @@ rcu_scale_init(void)
> > 	long i;
> > 	long j;
> > 	static struct rcu_scale_ops *scale_ops[] = {
> >-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> >+		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
> >+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> > 	};
> > 
> > 	if (!torture_init_begin(scale_type, verbose))
> >
> >base-commit: d21906b0aa1e9573cdb5e7acaca44966b9d1dcd2
> >
> 
> --- Thanks!
> "I'm not a very positive person" - Linus torvalds
