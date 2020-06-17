Return-Path: <SRS0=aJiN=76=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F10C433DF
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F04320776
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592402473;
	bh=TR/ZIoic71Z+LVpb9wxHdEaAbmWDYpM7yZy9Bl96Dpk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=n9TUrUvGmM3w0qanXdOGP/hEVQgIQ9sS0ChypY28yrStcrilybYPuIEX0DM5H8XRg
	 bhsLtRvH6Ny6jYIYmmqtA9Bo4FrqYIu88YLHLcGVyOwloFq2q6nK+LPPnjG67uJdHF
	 P7PoVgFvh3nopYfO1ziyH+aMG70QV1Np/5wjIj9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQOBE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQOBC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Jun 2020 10:01:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCEB020776;
        Wed, 17 Jun 2020 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592402460;
        bh=TR/ZIoic71Z+LVpb9wxHdEaAbmWDYpM7yZy9Bl96Dpk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B9FdY7cTQULMbJ+4iUXKOahhkeOlWb5yfvZYHWoVu8O/H+yJlAyFTEl4oacfuyQ31
         QrqXiLex9V/m9EY5WfQXITmVoCE+iJMq4R8siZNekfMjFVAH9SvjGCXDD763qNVmZf
         dnoFRvgSK2fHoKQ53L8LzHvM01YEssbPqbYWrn/g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B260D3522653; Wed, 17 Jun 2020 07:01:00 -0700 (PDT)
Date:   Wed, 17 Jun 2020 07:01:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: CPU trying to start a GP when no CBs were assigned new GP numbers
Message-ID: <20200617140100.GJ2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAEXW_YTdapsuKbZz=oAGKEnaXW=VJHTnGuy1qymy-du8mmKNjA@mail.gmail.com>
 <20200617040614.GI2723@paulmck-ThinkPad-P72>
 <20200617063954.GA73282@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20200617063954.GA73282@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2020 at 02:39:54AM -0400, Joel Fernandes wrote:
> On Tue, Jun 16, 2020 at 09:06:14PM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 16, 2020 at 08:24:37PM -0400, Joel Fernandes wrote:
> > > Hi,
> > > I am seeing something a bit strange with RCU where it is trying to
> > > start a GP twice from a CPU even though no new CB was queued on that
> > > CPU. It is quite possible that I'm missing something. Anyway, I wrote
> > > a patch to add some tracing when CBs are queued into the segcb. I am
> > > planning to post this trace patch later.
> > > 
> > > The trace in the link below shows CPU2 queuing around 5 CBs, which
> > > then gets accelerated at 5.192123. The GP thread running on CPU3
> > > starts a new GP. Now the CPU2 softirq runs again (roughly 1ms after
> > > the previous acceleration). The softirq runs probably because the GP
> > > thread is expecting a QS report from CPU 2.  When the CPU2's softirq
> > > runs though, it does an acceleration again which triggers a second new
> > > GP start. This seems a bit unnecessary AFAICS - because the need for
> > > GP *832 was already recorded which is all CPU2 should really be caring
> > > about right?
> > > 
> > > Here is the trace: https://pastebin.com/raw/AYGzu1g4
> > 
> > Assuming that the WAIT= and NEXT_READY= numbers are grace-period numbers,
> 
> In the trace there are 2 numbers for WAIT and NEXT_READY each, number of
> callbacks and gp numbers. Sorry, should have clarified that.

Ah, I see.  What are you doing to compute the number of callbacks?

> > this trace is expected behavior for two sets of callbacks, one that
> > arrived at CPU 2 by time 5.192121 and another that arrived between then
> > and time 5.193131.
> 
> There is just 1 set of callbacks.
> > 
> > So I have to ask...  What tells you that no callbacks arrived at CPU 2
> > during this interval?
> 
> Because there is no rcu_callback tracepoint fired in the interim. The number
> of callbacks that I'm tracing also confirm this.
> 
> > 
> > On the other hand, if CPU 2 is offloaded, what you might be seeing is
> > the delayed drain of callbacks from the bypass.
> 
> Sorry should have clarified it was not offloaded.
> 
> I dug more deeper and noticed that during acceleration, it is possible that
> the gp_seq numbers of empty segments are updated. In this case,
> rcu_segcblist_accelerate() still returns true resulting in starting of a new
> future GP. The below patch cures it, but I'm not sure if it introduces other
> issues. In light testing, it appears working. WDYT?

You are quite correct that empty segments should not be assigned
grace-period numbers.  Or at least that any such grace-period numbers
should not be taken very seriously.

> ---8<-----------------------
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 5f4fd3b8777ca..ebdba1d95f629 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -446,7 +478,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>   */
>  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  {
> -	int i;
> +	int i, oldest_seg;
>  
>  	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
>  	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> @@ -465,6 +497,9 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
>  			break;
>  
> +	/* The oldest segment after which everything later is merged. */
> +	oldest_seg = i;
> +
>  	/*
>  	 * If all the segments contain callbacks that correspond to
>  	 * earlier grace-period sequence numbers than "seq", leave.
> @@ -488,10 +523,19 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  	 * where there were no pending callbacks in the rcu_segcblist
>  	 * structure other than in the RCU_NEXT_TAIL segment.
>  	 */
>  	for (; i < RCU_NEXT_TAIL; i++) {
>  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_NEXT_TAIL]);
>  		rsclp->gp_seq[i] = seq;
>  	}
> +
> +	/*
> +	 * If all segments after oldest_seg were empty, then new GP numbers
> +	 * were assigned to empty segments. In this case, no need to start
> +	 * those future GPs.
> +	 */
> +	if (rcu_segcblist_restempty(rsclp, oldest_seg))
> +		return false;
> +
>  	return true;
>  }

Looks like this needs a focused test program.  ;-)

Please see attached for an outdated test userspace program.  It probably
needs help to check for this additional case.  And probably also other
changes to account for three years of change.

This test program works by copying files from the designated Linux
source tree, then building them into a userspace torture test.

							Thanx, Paul


--lrZ03NoBR/3+SXJZ
Content-Type: application/x-gtar-compressed
Content-Description: rcusegcblisttest.2020.06.17a.tgz
Content-Disposition: attachment; filename="rcusegcblisttest.2020.06.17a.tgz"
Content-Transfer-Encoding: base64

H4sIAAAAAAAAA+xcfXPbNpPPv9angPN0UsmRbFG2nKdV7eccx049Teyc7UyeXCejoUhIYkyR
LEFZUZvcZ7/dBV8AUqQk10nvruYksQwCi8ViX367gBKYn/oj1x+Ybn/MTZuHj+7/acOzv79P
P+HJ/4SXe4+MXaPdMfbaz7odaDf2uu3uo9FX4KXwTEVkhjBl6PtRVb9l7/OL+z/ydDvM8icT
7kUHz9om57bZsTo/DPb2bKPL7bbxT9iWH6zus85uuzuAz+0feO2v5vnhub8ntKaCj6yB64ho
5yvNgfbw7Fm33P7hc87+d7t7nUfdr8SP9vzN7V/b/+2REzkjzw/5vc4h/f9ehf/fze9/t7tr
PPomQvyb7//WtpgFNfzXr0VcRH1QiH6qETXtt+0xdPQf3P//p0ezf2vMrZttMb7nOZbZ/367
aP8G/rxnPhY+f3P7/8fmzsDxdsS4Vjs92IkmQaoE2999V4tCM2DfhxPWGrLvTr9n7VrNCtjO
2J/wHYgVO67jTT+1Otv7rcgJdhzPcqc2l607OdfBtLdVZG546HEXxxdo5N3RXahYOSpWzbJY
a8RaPis6QNY645Mgmvdj7gU0xB8X9AZa2zsLiByC8GrWJIAfucn9afTX+lPN/vWl3hscvAP+
2+9CvviA/77+U7X/0o7//Bx32P9nzzrdh/3/Bs/y/Xe8iIfhNAB/e8c5luL/wv53Okan/RD/
v8GzfP9lIL3z5j+60/4bu3t7D/v/DZ7l+x/NAy7+zPbfaf87uw/2/y0ebf+H5g3/Uzu9+Fmy
/7ttwyjU//eNB/v/Fg9at82HkJ1FbOD7bq/GvemE/VHbGJqu4OyAtZu1jSic4kejWfvSq9UE
/GpFzDJdd2BaN3RwhCMWtm95/FPUq23c+o7N6lvDqWc16ot74r+NXu0L6/fNKAqdwTTi/X69
brrOyON2XTi/c39YJ0pbDXh6tX8A747HKasiIhrJWvr+6PLy6H3/6uy/TupmgyWU4OMOiz/D
L7+2PzQa6ZDnb89eveg/f/uyf3Fet3zPdiLH92AwMdCIh1ljM/zVYC3W2drcVLqplN4dXZ4D
EfhzfFK3GswUgodRHboXO5W+TxjJvc5WeHx8cnUl5/gEXG4Bm64ZOS4kqrDHwCq0bjWewI+M
6OXJ0Yt0iE4hY+zy7Pokbm2yW9MF4n/kpztgdXzTY18UlsQk6E8G9Qbsp5h7Fv0zDn0PJFdX
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

--lrZ03NoBR/3+SXJZ--
