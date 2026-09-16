Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191C402BAB;
	Wed, 16 Sep 2026 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569381; cv=none; b=OQLk1u5XlfZEiBEmedQwfD37POsVteq8UpGGOd7T8WWaS8cqhUfwLrKShwtwz8Eu6xU/hgY/R58WGibHcAEbc1DKmG6tOGGgrls8ItM1b25fI5WTTxgxTlBd7OdIKP3GaesSF4CwEVmdlCb9ZlW/435UkiObVXHyk/yM6czYouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569381; c=relaxed/simple;
	bh=ti4+pW0dDL3TjY2OKP/U36jIXIpKlq/LSzHvzbaZckk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwOW9P3yMiXzj8o+RsclsFPKj1jf77JFofljpmFxDwpYXud1KXNpEExxdnFl0tBzpnJqD8SnhUtcM18pahDAYDkKlXX+RY14BY4dwN0RFoC8Dcj6p6Dp2Z24P66OoF73XAm9jWT57LK5bvq1K3OqCiTC4gaglqoYn3gWt0/rI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deXaKpmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deXaKpmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5720F1F000FF;
	Wed, 16 Sep 2026 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569379;
	bh=/dxfXm1FWSeINsH5rdfHX2nbZ0VC1dN9z6C1G+ZITBs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=deXaKpmgO33760WTSbnf4GCauSGnNc1ZoVLvmAg/v56J4rdVA8AA92ailZQI2UTqb
	 wigI1YMdh4ChZpIqv8kqlO6/QGu5t51lA4PzTaR3S3RS894TWQ8FvV/MOUHsdbOrBo
	 fAEWKqFuFReF65k6uDx1ldTig+vx0oyJGxKbVkPXiqz6rRLpfP2UXlCsFf/5yOq10q
	 GvLeSRD6GDt+Q2eQSrV9G0vr3S4bVMBeWhLZMdvlYwCAE+29sW9h4NqSsDepaeq62/
	 8n5IhLRHYUoqNjNBxeyN0KQUDCIS7KpkwmlR3V7Jl7+CuRFdo7kt0BEBht15h0mjy9
	 XDYaJn0sIf+Xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 526CFCE04DE; Wed, 16 Sep 2026 07:36:19 -0700 (PDT)
Date: Wed, 16 Sep 2026 07:36:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: joelagnelf@nvidia.com, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	qiang.zhang@linux.dev, rostedt@goodmis.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v2] rcu: Align stall warning 'idle=' output with
 documentation
Message-ID: <9650b646-0722-4243-bd96-7a78768c9db8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260105032112.1156359-1-dolinux.peng@gmail.com>
 <483ad434-4512-442e-ae6c-4108d5af5e49@gmail.com>
 <ea36a1e2-2940-4385-9b1d-fb197f1b562a@paulmck-laptop>
 <CAErzpms_CF5V+3T0i=iG9p7Q5uQS1287whvOe9iXhFkAGvE90w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAErzpms_CF5V+3T0i=iG9p7Q5uQS1287whvOe9iXhFkAGvE90w@mail.gmail.com>

On Wed, Sep 16, 2026 at 09:37:50PM +0800, Donglin Peng wrote:
> On Sat, Sep 12, 2026 at 12:06 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Sep 04, 2026 at 08:24:05PM +0800, Peng Donglin wrote:
> > > On 1/5/26 11:21, Donglin Peng wrote:
> > > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > > >
> > > > The RCU stall warning message includes an "idle=" field to indicate
> > > > the dyntick-idle state of a CPU. According to Documentation/RCU/stallwarn.rst,
> > > > the hexadecimal number before the first '/' represents the low-order 16
> > > > bits of the dynticks counter. An even value denotes that the CPU is in
> > > > dyntick-idle mode, while an odd value indicates otherwise.
> > > >
> > > > This was valid until commit 171476775d32 ("context_tracking: Convert state to atomic_t"),
> > > > which merged the context-tracking state and dynticks counter into a
> > > > single atomic variable. In the new layout, the dynticks counter occupies
> > > > the higher bits starting from CT_RCU_WATCHING_START.
> > > >
> > > > However, the current stall warning code prints the value from
> > > > `ct_rcu_watching_cpu()`, which returns `atomic_read(&ct->state) &
> > > > CT_RCU_WATCHING_MASK`. This masks out (clears) the lower state bits,
> > > > resulting in a value that is always even. This obscures the CPU's true
> > > > idle state and makes the output inconsistent with the documentation.
> > > >
> > > > To restore consistency between the code's output and the documentation,
> > > > shift the atomic value right by CT_RCU_WATCHING_START bits before printing.
> > > > This extracts and displays only the relevant dynticks counter portion,
> > > > allowing the parity (even/odd) to correctly reflect the CPU's dyntick-idle
> > > > state.
> > > >
> > > > Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
> > > > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > > > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > > ---
> > > > v2:
> > > >   - Use CT_RCU_WATCHING_START to replace ilog2(CT_RCU_WATCHING) to clean
> > > >     up the code, thanks to Zqiang.
> > > >   - Clarify the commit message.
> > > > ---
> > > >   kernel/rcu/tree_stall.h | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > > index b67532cb8770..fd9d7fd6e17c 100644
> > > > --- a/kernel/rcu/tree_stall.h
> > > > +++ b/kernel/rcu/tree_stall.h
> > > > @@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
> > > >                     rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
> > > >                             "!."[!delta],
> > > >            ticks_value, ticks_title,
> > > > -          ct_rcu_watching_cpu(cpu) & 0xffff,
> > > > +          (ct_rcu_watching_cpu(cpu) >> CT_RCU_WATCHING_START) & 0xffff,
> > > >            ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
> > > >            rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
> > > >            data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
> > >
> > > Gentle ping on this patch. Thanks!
> >
> > The advantage of the current code is that the CT_STATE_KERNEL,
> > CT_STATE_IDLE, CT_STATE_USER, and CT_STATE_GUEST information is visible
> > in the lower two bits of that hex number.
> >
> > Now, if you wanted to print that information symbolically and then
> > shift down the counter, that might well be a valuable improvement.
> > Given corresponding updates to stallwarn.rst, of course.
> 
> Thanks, that makes sense. I'll print the state symbolically, shift down
> the counter, update stallwarn.rst accordingly, and send a v3.

Sounds good, and looking forward to it!

							Thanx, Paul

> > Or am I missing something subtle here?
> >
> >                                                         Thanx, Paul
