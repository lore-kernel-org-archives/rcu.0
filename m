Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED78287D;
	Tue, 22 Oct 2024 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556489; cv=none; b=HUah9zNNL3/s3Nk/eohy4YByPd3XG49OgVycUBQrzIOQSWfMTBwmadXmwev6wNGAjtivXZ3tERhdQP7/PqPcpvUw57utqD1K7uFipleAoNNyoEaPo1S+iFgPT7EoM14Q75k2hJcBuncP2vLQXLmUooWZJuVftEu00E6avvjAkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556489; c=relaxed/simple;
	bh=TBgXPGOZie5nnxV2HGSGU2pxHnXG9JCIXis3p1TO+vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwhoeZiUXxJWRe2qo2Qru2Yx4d+HR4ouskmMRwb2zzDcg6nzf6akKv7hAK9ZuS1ScHqPkmlUlcuZjW9VhriHWLdXa6y4LdY9Tkc0K3k6vMe8RRfseWlbyEwa6Cn6cJ/yODMDQE2xr0B0F5K/IBcuKX1QQAWhpenET/SmXznozUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBKu9akt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBKu9akt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA2EC4CEC3;
	Tue, 22 Oct 2024 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729556488;
	bh=TBgXPGOZie5nnxV2HGSGU2pxHnXG9JCIXis3p1TO+vQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cBKu9aktBjNKr8TgKRs+B/1qxfDGk+2Dgb3d65AfA+ZbxA6DjJAsoXqIiFRSuMRnG
	 2CHAf3k2PQwwGCgtF1Gms6aIP6Y8L+yhiBxOtuOn2cNiZxTDK0T6qC9QOrJCxTp0+F
	 0W2Fndl+YimeQlGATu1Lf1TRvcJ+97E58292ryfYy8+quA09nQcNfVdarrLrU1tVpT
	 BSzAPTTdbGqPw/wj1ozVqNmFPX2uemyRCzxnkvVfcdbY6lRFQS7FkdTfF2gclMGNbB
	 LnnPc6Q4PXt7BtCQHU7vTtGCe5QjA3tKnHSDiIH+ETYF47pXoBzGXJBww0TK5MT5OP
	 usUjxpQCHTYtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C89FBCE0F74; Mon, 21 Oct 2024 17:21:27 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:21:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, peterz@infradead.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <5fbd5ff1-8cb8-425f-be5f-7ed9fe4edf1c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <CAEf4BzZU4ysQznVEctzijCUyuwN0TQXsxg_C16v3mmhUOzspjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZU4ysQznVEctzijCUyuwN0TQXsxg_C16v3mmhUOzspjQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 04:50:44PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 21, 2024 at 3:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > For almost 20 years, the int return value from srcu_read_lock() has
> > been always either zero or one.  This commit therefore documents the
> > fact that it will be non-negative.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org
> >
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index bab1dae3f69e6..512a8c54ba5ba 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
> >   * a mutex that is held elsewhere while calling synchronize_srcu() or
> >   * synchronize_srcu_expedited().
> >   *
> > - * The return value from srcu_read_lock() must be passed unaltered
> > - * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
> > - * the matching srcu_read_unlock() must occur in the same context, for
> > - * example, it is illegal to invoke srcu_read_unlock() in an irq handler
> > - * if the matching srcu_read_lock() was invoked in process context.  Or,
> > - * for that matter to invoke srcu_read_unlock() from one task and the
> > - * matching srcu_read_lock() from another.
> > + * The return value from srcu_read_lock() is guaranteed to be
> > + * non-negative.  This value must be passed unaltered to the matching
> > + * srcu_read_unlock().  Note that srcu_read_lock() and the matching
> > + * srcu_read_unlock() must occur in the same context, for example, it is
> > + * illegal to invoke srcu_read_unlock() in an irq handler if the matching
> > + * srcu_read_lock() was invoked in process context.  Or, for that matter to
> > + * invoke srcu_read_unlock() from one task and the matching srcu_read_lock()
> > + * from another.
> 
> For uprobe work I'm using __srcu_read_lock() and __srcu_read_unlock().
> Presumably the same non-negative index will be returned/consumed there
> as well, right? Can we add a blurb to that effect for them as well?

Does the change shown below cover it?

> Otherwise LGTM, thanks!
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thank you -- I will apply on my next rebase.

						Thanx, Paul

> >   */
> >  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
> >  {

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 07147efcb64d3..3d587bf2b2c12 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -738,7 +738,8 @@ EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.
- * Returns an index that must be passed to the matching srcu_read_unlock().
+ * Returns a guaranteed non-negative index that must be passed to the
+ * matching srcu_read_unlock().
  */
 int __srcu_read_lock(struct srcu_struct *ssp)
 {
