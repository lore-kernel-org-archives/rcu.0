Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0A351C0B;
	Sat,  3 Oct 2026 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791049988; cv=none; b=CQhbEEVIflMvZIL9aN6ySmQnUp00ZC3Qnv5TkH8FpW8rwxDr2C/Eaxz1/i0hbk2HGoSypuyH+CGUA78L2dtlwKuxWo+uTGMQ28ZIhlp9ZiM+EoIgIzfow+AiNAiGq1nA9FQCvUXz0Y3fsIdbzpPPPt0RvZJgUNC1yfkhTj4pcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791049988; c=relaxed/simple;
	bh=GxbxeVZPcceHPAZqr6pN8+RQLGUjsX8ar4+WiLyAi7I=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=RucgUILH2Akt8sKGPMx57jt2CBfeMUu9ZxxJ2EQApCIF8lN3ZNjgjGnzjVuA/7VJtuu6BC8pvXPsMlftVJwHK4t8fc4kMHdOm/fSY8543JZYljvMT2znfxe0MT9IiAJV0lgknWkyRIugjCMKGfsNRAP0V5BkIeaXjpGftBKdy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=BlmtEhYW; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=diPrgplY; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="BlmtEhYW";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="diPrgplY"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791049966; bh=Eke+zid+5Nzy32ms7wldV6x
	oiQtBAWDv85gmlM+wM9I=; b=BlmtEhYWU3b+6k6NrQnZelER4Xfi+OTWCROSQtXq0+Ioe3oEoZ
	G6iOcxZtXJIzblXIXh74dNMQJSM6lWWwuGGlrXltnp/Svoh/EX8jIwDMVXA+pj1ZOY2u9HRzNxx
	6Xdg9ECn3XDnPwu7G/Moz2JyIvQEixyxACp0A5bu9bg9wzjfmxwFuH1bRC3j8S7aRNUk9ubhxGo
	gE+IkdS6vjlARdMU1iE0eeMD1WQG3kEzECUsOzvFmAP2BUb4wUIQeH093ZAsKKdkmRB2s2OZPlA
	16FhoWuqUbWoajuwcK0Lpp3XRXBQwzmzZNPbvBC4dvW94Hr0gZD3qF/uiOlI1Izd5Xg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791049966; bh=Eke+zid+5Nzy32ms7wldV6x
	oiQtBAWDv85gmlM+wM9I=; b=diPrgplYzcpGpsVfSewDjxPhr1atiDvU5/tAmPDC/WJfY83Rsb
	WCfbeM4sTjyee5eQBBn35L3vMEBhZ9AGWBBw==;
Date: Sat, 03 Oct 2026 18:52:44 +0100
From: Bradley Morgan <brads@mainlining.org>
To: kunwu.chan@gmail.com
CC: boqun@kernel.org, dave@stgolabs.net, frederic@kernel.org,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 neeraj.upadhyay@kernel.org, paulmck@kernel.org, qiang.zhang@linux.dev,
 rcu@vger.kernel.org, rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH v2] rcuscale: add srcua scale type
In-Reply-To: <20261003161720.240855-1-kunwu.chan@gmail.com>
Message-ID: <A3BA2086-5718-45BB-8B3E-35C1D2CA7B63@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 3 October 2026 17:17:19 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:
>Add support for scaling atomic SRCU grace periods using
>srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
>synchronize_srcu_atomic().
>
>Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

1: why didn't u cc me
2: why did you ommit my tag? I tend to review based on correctness, cuz idk pauls preferences, once I do I'll be a better rcu reviewer.

>---
>Changes since v1:
>- Rename srcu_atomic_ctlp to srcua and reuse srcu_ctlp for
>  SRCU operations, as suggested by Paul.
>- Reuse the existing SRCU cleanup and completed helpers by
>  initializing srcu_ctlp in srcu_atomic_scale_init().
>- Add .stats using srcu_scale_stats().
>- Use "srcua" to match the existing "srcu" and "srcud" scale
>  type names.
>- Use synchronize_srcu_atomic() for both normal and expedited
>  scale tests.
>
>v1: https://lore.kernel.org/all/20260927100359.3903688-1-kunwu.chan@gmail.com/
>Tested with kvm.sh --torture rcuscale scale_type=srcua on x86_64 and
>arm64, alongside gp_exp=1 and PROVE_LOCKING=y: no warnings or lockdep
>splats.
>---
> kernel/rcu/rcuscale.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 40 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>index 1097ec15879c..b172882824ac 100644
>--- a/kernel/rcu/rcuscale.c
>+++ b/kernel/rcu/rcuscale.c
>@@ -293,6 +293,44 @@ static struct rcu_scale_ops srcud_ops = {
> 	.name		= "srcud"
> };
> 
>+static struct srcu_struct srcua;
>+
>+static int srcu_scale_atomic_read_lock(void)
>+{
>+	return srcu_read_lock_atomic(srcu_ctlp);
>+}
>+
>+static void srcu_scale_atomic_read_unlock(int idx)
>+{
>+	srcu_read_unlock_atomic(srcu_ctlp, idx);
>+}
>+
>+static void srcu_scale_atomic_synchronize(void)
>+{
>+	synchronize_srcu_atomic(srcu_ctlp);
>+}
>+
>+static void srcu_atomic_scale_init(void)
>+{
>+	srcu_ctlp = &srcua;
>+	init_srcu_struct_atomic(srcu_ctlp);
>+}
>+
>+static struct rcu_scale_ops srcua_ops = {
>+	.ptype		= SRCU_FLAVOR,
>+	.init		= srcu_atomic_scale_init,
>+	.cleanup	= srcu_sync_scale_cleanup,
>+	.readlock	= srcu_scale_atomic_read_lock,
>+	.readunlock	= srcu_scale_atomic_read_unlock,
>+	.get_gp_seq	= srcu_scale_completed,
>+	.gp_diff	= rcu_seq_diff,
>+	.exp_completed	= srcu_scale_completed,
>+	.sync		= srcu_scale_atomic_synchronize,
>+	.exp_sync	= srcu_scale_atomic_synchronize,
>+	.stats		= srcu_scale_stats,
>+	.name		= "srcua"
>+};
>+
> #ifdef CONFIG_TASKS_RCU
> 
> /*
>@@ -1110,7 +1148,8 @@ rcu_scale_init(void)
> 	long i;
> 	long j;
> 	static struct rcu_scale_ops *scale_ops[] = {
>-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>+		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
>+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> 	};
> 
> 	if (!torture_init_begin(scale_type, verbose))
>
>base-commit: d21906b0aa1e9573cdb5e7acaca44966b9d1dcd2
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
