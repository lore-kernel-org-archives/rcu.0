Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF6377A83;
	Sun, 27 Sep 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790539222; cv=none; b=IyPvwlzaDHFCKGEqjk2dK1eN1WGo3iv0m9KQO7jXPTBFpRncgf7NyU+kOZatv4XWu7ZqJpLBJUikBlXqA2i4yv4RzhOHDebojo665cryTkkUFSdPzkCGb97fhEXH5y0/E7CmhqTi9ChNkMA4eSSUWpiaU80si6kTMEXZm4C6rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790539222; c=relaxed/simple;
	bh=SeLQSuQGwU9qsys0t0pYmDOpg2+fG+NoUyO9dpYvIBU=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=YEzpiD5hOej+G9CC7PefTRxJfSMLGrMlj8Fr8PY94D3SV/JwiTfvsY1t4cX6PRjRVlj5+aGRapUavhbzFkTzGeUsedTJd+FIx7MU/cuXJN7Ag25GO+Z6UpAfi3PZuSBW+LrdOFkqM8/+/UDwg4ZpYdpNoayF6+nceSPvtFhBkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Ly5VTmK9; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=KqcH46cf; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Ly5VTmK9";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KqcH46cf"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790539207; bh=EWRD9Z8tz8/kpl/2wpMTdBB
	fWlCLUqMDxxOx7tDpxME=; b=Ly5VTmK9EBVV2x+YmeIAf2sdf4u7VIf8kk5LTeiUr5uX6MIuIA
	/ydpjk5sYOXB+6SWjBXO+FAaIFFm7GFGDiQSbbOFiE1rXXv8YvHj5hlU8op2ACo/QT+WJlzAlhW
	AM+Ze2xxo//eXbbNRddyTO8sM7Rgabq9DzRA1YJ9Q7pPel23km2EAuao4A9NaeH14ADC2nS5S3q
	P5vq1bW5dObjWD0bGxAjM/WEYcG1Ud72DJVkXbFuoHLG9VyJOU0AatMnoGNGAIuUzNxndJOIncm
	i9VSMd5ZqguL39keUBO5NMok779mgESzKwGMVLA8FhGQDPnf3ekrFJS61+nv70FZcEA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790539207; bh=EWRD9Z8tz8/kpl/2wpMTdBB
	fWlCLUqMDxxOx7tDpxME=; b=KqcH46cfSCtarNybUafavHnVd7XP3v/Z6osk4Znk+MtouN7ABM
	IorbIz08mba34TNJ+D/oeS9gx1FkrpOiDMCQ==;
Date: Sun, 27 Sep 2026 21:00:07 +0100
From: Bradley Morgan <brads@mainlining.org>
To: kunwu.chan@gmail.com
CC: boqun@kernel.org, dave@stgolabs.net, frederic@kernel.org,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 neeraj.upadhyay@kernel.org, paulmck@kernel.org, qiang.zhang@linux.dev,
 rcu@vger.kernel.org, rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH] rcuscale: add srcu_atomic scale type
In-Reply-To: <20260927100359.3903688-1-kunwu.chan@gmail.com>
Message-ID: <A425E486-AAE4-4A48-89CA-959A28094A51@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 September 2026 11:03:59 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:
>Add support for scaling atomic SRCU grace periods using
>srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
>synchronize_srcu_atomic().
>

Ummm. Ok then!

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>---
> kernel/rcu/rcuscale.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 46 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>index 5aca31c3c01d..86f1a912ebee 100644
>--- a/kernel/rcu/rcuscale.c
>+++ b/kernel/rcu/rcuscale.c
>@@ -264,6 +264,51 @@ static struct rcu_scale_ops srcu_ops = {
> 	.name		= "srcu"
> };
> 
>+static struct srcu_struct srcu_atomic_ctlp;
>+
>+static int srcu_scale_atomic_read_lock(void)
>+{
>+	return srcu_read_lock_atomic(&srcu_atomic_ctlp);
>+}
>+
>+static void srcu_scale_atomic_read_unlock(int idx)
>+{
>+	srcu_read_unlock_atomic(&srcu_atomic_ctlp, idx);
>+}
>+
>+static void srcu_scale_atomic_synchronize(void)
>+{
>+	synchronize_srcu_atomic(&srcu_atomic_ctlp);
>+}
>+
>+static void srcu_atomic_scale_init(void)
>+{
>+	init_srcu_struct_atomic(&srcu_atomic_ctlp);
>+}
>+
>+static void srcu_atomic_scale_cleanup(void)
>+{
>+	cleanup_srcu_struct(&srcu_atomic_ctlp);
>+}
>+
>+static unsigned long srcu_atomic_scale_completed(void)
>+{
>+	return srcu_batches_completed(&srcu_atomic_ctlp);
>+}
>+
>+static struct rcu_scale_ops srcu_atomic_ops = {
>+	.ptype		= SRCU_FLAVOR,
>+	.init		= srcu_atomic_scale_init,
>+	.cleanup	= srcu_atomic_scale_cleanup,
>+	.readlock	= srcu_scale_atomic_read_lock,
>+	.readunlock	= srcu_scale_atomic_read_unlock,
>+	.get_gp_seq	= srcu_atomic_scale_completed,
>+	.gp_diff	= rcu_seq_diff,
>+	.exp_completed	= srcu_atomic_scale_completed,
>+	.sync		= srcu_scale_atomic_synchronize,
>+	.name		= "srcu_atomic"
>+};
>+
> static struct srcu_struct srcud;
> 
> static void srcu_sync_scale_init(void)
>@@ -1176,7 +1221,7 @@ rcu_scale_init(void)
> 	long i;
> 	long j;
> 	static struct rcu_scale_ops *scale_ops[] = {
>-		&rcu_ops, &srcu_ops, &srcud_ops,
>+		&rcu_ops, &srcu_ops, &srcu_atomic_ops, &srcud_ops,
> 		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> 		HAZPTR_SCALE_OPS
> 	};
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
