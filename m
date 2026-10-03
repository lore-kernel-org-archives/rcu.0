Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5C37F012;
	Sat,  3 Oct 2026 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071566; cv=none; b=IJZijdydEqKD7Hrdv4Os3N+vXuW7wvIH/eQ55h8MK4WEzmPYZXYd7f03dcTZA4iWqFFA5S/RkzCyEepivhDtsZWRndYy9f+jDTC5XpzsMOAGFX/PIwA9ZVur9mQBnkjGXWdVInTc9bqQxrpsh2VhKZ24hahwEfmZOSUBxu+t36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071566; c=relaxed/simple;
	bh=7a0XDAvS3fDy1cmZWgqS5qcFXOa0J7fpuJbx+nPX9QQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HDEtd+9itopN5MQUn4W8rFmyo4YIK+2veVEM6hYV/Jzn6UHDmolFvZC6aUnl+yDKs0NvyW6kJIoPYQ5n9QG4jIta2wnHg9rL908D1RFsIu4ig8SJImTDhMTxynflGvc1bPgbWa+6TAQe+5s7EXwRC+QNY1wQxuIGmTaY5uKS9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=j3QD72du; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=PyP2IyK4; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="j3QD72du";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="PyP2IyK4"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791071536; bh=wYBv3z5a4HfOvjY83WOizp+
	yR6aTEneKp2ZCD0fxCYE=; b=j3QD72duUBsqYdHOpQCr34HNIO5hEdrSBKpaI+mHaKOXDI9C7m
	5/emW2OJ2ERwzQ2NtRr2Q64HRjTHzIsl+//5EwxSyFBKfAQ50Z9ETr73fUnFE0BxO96LS0dcgtq
	EG8d9FUCaArxoEmaGMi9kukCYJ5dDUGSgCrv+nGIbWcu0wzJxKqOnIyWvB+EN29R+f0Sh5hJV+i
	6/5oJCRAlCx670qEn8RDFif/6qPH5C5687C+/JG10WcrefD9pWbQDLWSIoVCpF4Rq74w1kwGB0v
	gOq/Lmhv8Ks6XVNJroAQxeEEezjGP25nDNjAFvFQfhq16vDg4nHwd9CEyys3/+VnsPg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791071536; bh=wYBv3z5a4HfOvjY83WOizp+
	yR6aTEneKp2ZCD0fxCYE=; b=PyP2IyK4svEUXvrS7w+dpkGVsEHyaHrFwGgLlKvwdKo5EkSB/w
	tZcd58UwNc1/UGvuBPZBr7LRu3Euau8LJOCQ==;
Date: Sun, 04 Oct 2026 00:52:14 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: kunwu.chan@gmail.com, boqun@kernel.org, dave@stgolabs.net,
 frederic@kernel.org, jiangshanlai@gmail.com, joelagnelf@nvidia.com,
 josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
 urezki@gmail.com
Subject: Re: [PATCH v2] rcuscale: add srcua scale type
In-Reply-To: <463c8f04-e08b-49b7-b16f-e65def841cb6@paulmck-laptop>
References: <20261003161720.240855-1-kunwu.chan@gmail.com> <A3BA2086-5718-45BB-8B3E-35C1D2CA7B63@mainlining.org> <463c8f04-e08b-49b7-b16f-e65def841cb6@paulmck-laptop>
Message-ID: <8E7E9F8D-D6B3-4F04-A0FA-2AEA8BF5DE1F@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 October 2026 00:43:48 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Sat, Oct 03, 2026 at 06:52:44PM +0100, Bradley Morgan wrote:
>> On 3 October 2026 17:17:19 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:
>> >Add support for scaling atomic SRCU grace periods using
>> >srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
>> >synchronize_srcu_atomic().
>> >
>> >Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> >Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>> 
>> 1: why didn't u cc me
>> 2: why did you ommit my tag? I tend to review based on correctness, cuz
>idk pauls preferences, once I do I'll be a better rcu reviewer.
>
>Take it easy, Bradley.
>
>Many in the Linux kernel community consider it polite to drop a tag
>from (or, as in this case, avoid adding a tag to) a patch that changed
>significantly.  On the CC issue, you did find the patch the first time
>without him CCing you.  ;-)
>
>Kunwu did nothing wrong here.

I'm annoyed but not mad, no grudges taken..

>
>							Thanx, Paul
>
>> >---
>> >Changes since v1:
>> >- Rename srcu_atomic_ctlp to srcua and reuse srcu_ctlp for
>> >  SRCU operations, as suggested by Paul.
>> >- Reuse the existing SRCU cleanup and completed helpers by
>> >  initializing srcu_ctlp in srcu_atomic_scale_init().
>> >- Add .stats using srcu_scale_stats().
>> >- Use "srcua" to match the existing "srcu" and "srcud" scale
>> >  type names.
>> >- Use synchronize_srcu_atomic() for both normal and expedited
>> >  scale tests.
>> >
>> >v1:
>https://lore.kernel.org/all/20260927100359.3903688-1-kunwu.chan@gmail.com/
>> >Tested with kvm.sh --torture rcuscale scale_type=srcua on x86_64 and
>> >arm64, alongside gp_exp=1 and PROVE_LOCKING=y: no warnings or lockdep
>> >splats.
>> >---
>> > kernel/rcu/rcuscale.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>> > 1 file changed, 40 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>> >index 1097ec15879c..b172882824ac 100644
>> >--- a/kernel/rcu/rcuscale.c
>> >+++ b/kernel/rcu/rcuscale.c
>> >@@ -293,6 +293,44 @@ static struct rcu_scale_ops srcud_ops = {
>> > 	.name		= "srcud"
>> > };
>> > 
>> >+static struct srcu_struct srcua;
>> >+
>> >+static int srcu_scale_atomic_read_lock(void)
>> >+{
>> >+	return srcu_read_lock_atomic(srcu_ctlp);
>> >+}
>> >+
>> >+static void srcu_scale_atomic_read_unlock(int idx)
>> >+{
>> >+	srcu_read_unlock_atomic(srcu_ctlp, idx);
>> >+}
>> >+
>> >+static void srcu_scale_atomic_synchronize(void)
>> >+{
>> >+	synchronize_srcu_atomic(srcu_ctlp);
>> >+}
>> >+
>> >+static void srcu_atomic_scale_init(void)
>> >+{
>> >+	srcu_ctlp = &srcua;
>> >+	init_srcu_struct_atomic(srcu_ctlp);
>> >+}
>> >+
>> >+static struct rcu_scale_ops srcua_ops = {
>> >+	.ptype		= SRCU_FLAVOR,
>> >+	.init		= srcu_atomic_scale_init,
>> >+	.cleanup	= srcu_sync_scale_cleanup,
>> >+	.readlock	= srcu_scale_atomic_read_lock,
>> >+	.readunlock	= srcu_scale_atomic_read_unlock,
>> >+	.get_gp_seq	= srcu_scale_completed,
>> >+	.gp_diff	= rcu_seq_diff,
>> >+	.exp_completed	= srcu_scale_completed,
>> >+	.sync		= srcu_scale_atomic_synchronize,
>> >+	.exp_sync	= srcu_scale_atomic_synchronize,
>> >+	.stats		= srcu_scale_stats,
>> >+	.name		= "srcua"
>> >+};
>> >+
>> > #ifdef CONFIG_TASKS_RCU
>> > 
>> > /*
>> >@@ -1110,7 +1148,8 @@ rcu_scale_init(void)
>> > 	long i;
>> > 	long j;
>> > 	static struct rcu_scale_ops *scale_ops[] = {
>> >-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>> >+		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
>> >+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>> > 	};
>> > 
>> > 	if (!torture_init_begin(scale_type, verbose))
>> >
>> >base-commit: d21906b0aa1e9573cdb5e7acaca44966b9d1dcd2
>> >
>> 
>> --- Thanks!
>> "I'm not a very positive person" - Linus torvalds

--- Thanks!
"I'm not a very positive person" - Linus torvalds
