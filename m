Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A28377011;
	Fri, 11 Sep 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142761; cv=none; b=IG1Gctvzu1MqtwXs0PjP9a9+BkwVj+TSw1JJvKfPvoV3g3jY3fq0VVwLlWEgu3uqRTVZA2dEVNG9NujuxI5nbeav3bEiA3VEvzXuzORfVtqhOyLEIqfEg9o86KlH6A6DHSQJGyGfdvtnjoXUT/giZYK5BUetR0rRYXYVGuHTta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142761; c=relaxed/simple;
	bh=y623zKvj5WFK6vh5rxBcAJnlnTCbTFJ9npK9Jcvpquo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/SILuMxH6NNUY4y1VXl5DdmpbzD1D9KYxvtvxIXs+eIUwMmy0eXjdybXLX+AZ5T7u2F+0Niss0s/eBXJqYCAWUV1lxl6xaEWN0LcQ2rHvCuXPwIhir1nlTWOQbOUIZ7Z4SXLIPEBVk7UTwJQGJQRMYyegPtm4TfWUPIK4IhzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk8BwnwX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk8BwnwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6AF1F000FF;
	Fri, 11 Sep 2026 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789142760;
	bh=2wrOYazY8nQ3ZFXBOJB+1T1IM8luOPP12v0FzLgIrEM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Fk8BwnwXMbAajPQfNAkdjM7GxQ05ezHyEjLMSYuUNBGC8V971DgzQAgb+XfbtwtSi
	 YRUZVNEphDjSzzmYj2i0Kd35FtAlji7d8EjEu2/1mL20AdGMDo+4Qyb5b5KJ8QQckq
	 mIvY6X0LebJ3EvIdZQYGEZ5Sb/2KwJPD3uhvxEyeEgpY3UxJ17ewDFEmx2CxhT6HA3
	 rnK24yViqITBG7CjQjMYa1ZtbmpzBENqQwNFUsyh0eKws4ja0X5eTMy6A6k1LXXDic
	 xAnbS3MfSpgSrnY1xM5yHQBBU3rclPmmDisubHLbptUyRXG85kko9WMKbOjYfjxME1
	 MfRu6bopojR8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B3CDBCE1902; Fri, 11 Sep 2026 09:05:59 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:05:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peng Donglin <dolinux.peng@gmail.com>
Cc: joelagnelf@nvidia.com, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	qiang.zhang@linux.dev, rostedt@goodmis.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v2] rcu: Align stall warning 'idle=' output with
 documentation
Message-ID: <ea36a1e2-2940-4385-9b1d-fb197f1b562a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260105032112.1156359-1-dolinux.peng@gmail.com>
 <483ad434-4512-442e-ae6c-4108d5af5e49@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483ad434-4512-442e-ae6c-4108d5af5e49@gmail.com>

On Fri, Sep 04, 2026 at 08:24:05PM +0800, Peng Donglin wrote:
> On 1/5/26 11:21, Donglin Peng wrote:
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> > 
> > The RCU stall warning message includes an "idle=" field to indicate
> > the dyntick-idle state of a CPU. According to Documentation/RCU/stallwarn.rst,
> > the hexadecimal number before the first '/' represents the low-order 16
> > bits of the dynticks counter. An even value denotes that the CPU is in
> > dyntick-idle mode, while an odd value indicates otherwise.
> > 
> > This was valid until commit 171476775d32 ("context_tracking: Convert state to atomic_t"),
> > which merged the context-tracking state and dynticks counter into a
> > single atomic variable. In the new layout, the dynticks counter occupies
> > the higher bits starting from CT_RCU_WATCHING_START.
> > 
> > However, the current stall warning code prints the value from
> > `ct_rcu_watching_cpu()`, which returns `atomic_read(&ct->state) &
> > CT_RCU_WATCHING_MASK`. This masks out (clears) the lower state bits,
> > resulting in a value that is always even. This obscures the CPU's true
> > idle state and makes the output inconsistent with the documentation.
> > 
> > To restore consistency between the code's output and the documentation,
> > shift the atomic value right by CT_RCU_WATCHING_START bits before printing.
> > This extracts and displays only the relevant dynticks counter portion,
> > allowing the parity (even/odd) to correctly reflect the CPU's dyntick-idle
> > state.
> > 
> > Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> > v2:
> >   - Use CT_RCU_WATCHING_START to replace ilog2(CT_RCU_WATCHING) to clean
> >     up the code, thanks to Zqiang.
> >   - Clarify the commit message.
> > ---
> >   kernel/rcu/tree_stall.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b67532cb8770..fd9d7fd6e17c 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
> >   			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
> >   				"!."[!delta],
> >   	       ticks_value, ticks_title,
> > -	       ct_rcu_watching_cpu(cpu) & 0xffff,
> > +	       (ct_rcu_watching_cpu(cpu) >> CT_RCU_WATCHING_START) & 0xffff,
> >   	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
> >   	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
> >   	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
> 
> Gentle ping on this patch. Thanks!

The advantage of the current code is that the CT_STATE_KERNEL,
CT_STATE_IDLE, CT_STATE_USER, and CT_STATE_GUEST information is visible
in the lower two bits of that hex number.

Now, if you wanted to print that information symbolically and then
shift down the counter, that might well be a valuable improvement.
Given corresponding updates to stallwarn.rst, of course.

Or am I missing something subtle here?

							Thanx, Paul
