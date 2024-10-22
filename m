Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693E40BF2;
	Tue, 22 Oct 2024 03:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567845; cv=none; b=SuXJxmB9RphYxu+Y7ZbBC+y2y+T7jYUo9qcHsKKeeWcBr6McFNELqgmt/DfHEtYd+s7vbnX5V2bwLnv85rE4973rX1NJdR2/Oj4g8cTRNYs70r2zmE3SYITYFpFSBlzoxus0L9LnHkQFLBy6+EY+pSIsGhLJvw8505C+YrRsabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567845; c=relaxed/simple;
	bh=vm043k6TgMA5PAnsJl3nt1ttFqSEZ5nEWOaT/UX0d+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJOUH1xXP3PrTWk/Qml1Fm73enLXpeiVfwC12GNur6+QOB6iCV8QzqAC3E0QZHnUltGI7vkix/cOMGleMV3i1uChsoqhMqUylEwQib6RqDirJisyaRPw7CArJzHoZXfoEr6InOpW7OBMs99CSWJFWmHceFcxp3jUlZxnib4HB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBL19Mv2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBL19Mv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C6DC4CEEC;
	Tue, 22 Oct 2024 03:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729567843;
	bh=vm043k6TgMA5PAnsJl3nt1ttFqSEZ5nEWOaT/UX0d+o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mBL19Mv2pBpL8rIZjVObq9GETsoLUTL91QatXbHpzVohKWd/oMQlLz2BwIQvTzkmf
	 iq/Hr3WpXTvGPDFTxnb1z8wcX4EmUG9Bmo6jE1ntVB/Oiyx1uXuGHopvV6PKB/rNjq
	 3BfS7v+TayTJMtouflfWdD3g78ZydMQ63EkZlrJEC7LPj2OniSi4mgTtYyGH53tIP+
	 ZUFgrjTQvJ48M+n7AKx/VHEQok0gGrGa9XorCOwmggKmcUZjvW+vYGbeEpi4uOnyet
	 LqfSMApjJICVIwAQnAp1FGBhG1uInn2opxQq4vaXwh9sXqYNEFen/RGRmpk4nM6AzK
	 nZyRsAGYjlZ9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3136BCE0F85; Mon, 21 Oct 2024 20:30:43 -0700 (PDT)
Date: Mon, 21 Oct 2024 20:30:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, peterz@infradead.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <22a02204-8d14-41ae-af40-dfea79dec09d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <CAEf4BzZU4ysQznVEctzijCUyuwN0TQXsxg_C16v3mmhUOzspjQ@mail.gmail.com>
 <5fbd5ff1-8cb8-425f-be5f-7ed9fe4edf1c@paulmck-laptop>
 <CAEf4BzbX5UtS=+Np5t68n8oRE2O2qGg5iDcikNFpvCTPBZU8kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbX5UtS=+Np5t68n8oRE2O2qGg5iDcikNFpvCTPBZU8kg@mail.gmail.com>

On Mon, Oct 21, 2024 at 07:01:02PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 21, 2024 at 5:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Oct 21, 2024 at 04:50:44PM -0700, Andrii Nakryiko wrote:
> > > On Mon, Oct 21, 2024 at 3:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > For almost 20 years, the int return value from srcu_read_lock() has
> > > > been always either zero or one.  This commit therefore documents the
> > > > fact that it will be non-negative.
> > > >
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Andrii Nakryiko <andrii@kernel.org
> > > >
> > > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > > index bab1dae3f69e6..512a8c54ba5ba 100644
> > > > --- a/include/linux/srcu.h
> > > > +++ b/include/linux/srcu.h
> > > > @@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
> > > >   * a mutex that is held elsewhere while calling synchronize_srcu() or
> > > >   * synchronize_srcu_expedited().
> > > >   *
> > > > - * The return value from srcu_read_lock() must be passed unaltered
> > > > - * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
> > > > - * the matching srcu_read_unlock() must occur in the same context, for
> > > > - * example, it is illegal to invoke srcu_read_unlock() in an irq handler
> > > > - * if the matching srcu_read_lock() was invoked in process context.  Or,
> > > > - * for that matter to invoke srcu_read_unlock() from one task and the
> > > > - * matching srcu_read_lock() from another.
> > > > + * The return value from srcu_read_lock() is guaranteed to be
> > > > + * non-negative.  This value must be passed unaltered to the matching
> > > > + * srcu_read_unlock().  Note that srcu_read_lock() and the matching
> > > > + * srcu_read_unlock() must occur in the same context, for example, it is
> > > > + * illegal to invoke srcu_read_unlock() in an irq handler if the matching
> > > > + * srcu_read_lock() was invoked in process context.  Or, for that matter to
> > > > + * invoke srcu_read_unlock() from one task and the matching srcu_read_lock()
> > > > + * from another.
> > >
> > > For uprobe work I'm using __srcu_read_lock() and __srcu_read_unlock().
> > > Presumably the same non-negative index will be returned/consumed there
> > > as well, right? Can we add a blurb to that effect for them as well?
> >
> > Does the change shown below cover it?
> 
> Yep, looks good, thank you! You might want to fix
> s/srcu_read_unlock/__srcu_read_unlock/, while at it, but that's
> orthogonal.

As long as we are in the area...  Please see below for the update.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 4433b7d3785d8d2a700f5ed5ca234c64bc63180e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Oct 21 15:09:39 2024 -0700

    srcu: Guarantee non-negative return value from srcu_read_lock()
    
    For almost 20 years, the int return value from srcu_read_lock() has
    been always either zero or one.  This commit therefore documents the
    fact that it will be non-negative, and does the same for the underlying
    __srcu_read_lock().
    
    [ paulmck: Apply Andrii Nakryiko feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Acked-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index bab1dae3f69e6..512a8c54ba5ba 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
  * a mutex that is held elsewhere while calling synchronize_srcu() or
  * synchronize_srcu_expedited().
  *
- * The return value from srcu_read_lock() must be passed unaltered
- * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
- * the matching srcu_read_unlock() must occur in the same context, for
- * example, it is illegal to invoke srcu_read_unlock() in an irq handler
- * if the matching srcu_read_lock() was invoked in process context.  Or,
- * for that matter to invoke srcu_read_unlock() from one task and the
- * matching srcu_read_lock() from another.
+ * The return value from srcu_read_lock() is guaranteed to be
+ * non-negative.  This value must be passed unaltered to the matching
+ * srcu_read_unlock().  Note that srcu_read_lock() and the matching
+ * srcu_read_unlock() must occur in the same context, for example, it is
+ * illegal to invoke srcu_read_unlock() in an irq handler if the matching
+ * srcu_read_lock() was invoked in process context.  Or, for that matter to
+ * invoke srcu_read_unlock() from one task and the matching srcu_read_lock()
+ * from another.
  */
 static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 07147efcb64d3..ae17c214e0de5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -738,7 +738,8 @@ EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.
- * Returns an index that must be passed to the matching srcu_read_unlock().
+ * Returns a guaranteed non-negative index that must be passed to the
+ * matching __srcu_read_unlock().
  */
 int __srcu_read_lock(struct srcu_struct *ssp)
 {
