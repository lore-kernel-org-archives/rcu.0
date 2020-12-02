Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2FAC8301C
	for <rcu@archiver.kernel.org>; Wed,  2 Dec 2020 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54330206D5
	for <rcu@archiver.kernel.org>; Wed,  2 Dec 2020 18:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgLBSLk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgLBSLj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Dec 2020 13:11:39 -0500
Date:   Wed, 2 Dec 2020 10:10:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606932658;
        bh=KL2OKD35QtHLbFQ0Piazz6J0wicIwPVycp/sxbwiJEo=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jqrQPuCgdbulaOyZBEcpmNueGcJwPGDDAUmzFsjfLWxik5qMv1MBKLy2KuLa5zra+
         MPNRa9Gj4oP3fX1qGcjuVmnGMF5JFRyM+7DIToYeksim37T3X2KjI46TWL8JHFLAB/
         Ki2/2vEMOEdhShGzMMD6aJnJXUYDg7WI0TiFOQw8z8RKvioq01MQp+UGILEvCO2voi
         XDG7xuZ+ilgCmVxDak7RXiDHY3QaSzVOo5f0OZwO31vBjwOGv6/mIM8TkN2lXoL0e9
         up7d6P6nu9aW/dJNu47EtM3bscOdHnDACyx4mh9oD/wm8vlUAAY2iRYKALK8AUpQ4j
         z4MJ+Z9mKh3pQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI0=?= =?utf-8?Q?=3A?= SRCU: Question
 on srcu_advance_state
Message-ID: <20201202181058.GP1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <7fc7b6b9-bcf2-fa78-1931-415d04a5ac1a@windriver.com>
 <20201121011132.GR1437@paulmck-ThinkPad-P72>
 <DM6PR11MB2635EF8668163B77B073C096FFFC0@DM6PR11MB2635.namprd11.prod.outlook.com>
 <20201125030338.GA5810@paulmck-ThinkPad-P72>
 <BYAPR11MB2632E04495F1717FE8824664FFF80@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2632E04495F1717FE8824664FFF80@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 27, 2020 at 08:19:32AM +0000, Zhang, Qiang wrote:
> 
> On Mon, Nov 23, 2020 at 01:59:37AM +0000, Zhang, Qiang wrote:
> >
> >
> > ________________________________________
> > 发件人: Paul E. McKenney <paulmck@kernel.org>
> > 发送时间: 2020年11月21日 9:11
> > 收件人: Zhang, Qiang
> > 抄送: rcu@vger.kernel.org; Joel Fernandes
> > 主题: Re: SRCU: Question on srcu_advance_state
> >
> > [Please note this e-mail is from an EXTERNAL e-mail address]
> >
> > On Fri, Nov 20, 2020 at 04:30:15PM +0800, Zhang,Qiang wrote:
> > > Hello Pual
> > >
> > > sorry to disturb you, I also have some quesetion for you:
> > >
> > > in srcu_advance_state function, when seq state == SRCU_STATE_SCAN1, we will
> > > check, if the previous readers critical region exits, will be returned
> > > directly.
> > >
> > > I'd like to know under what scenario this will happen?
> >
> > >Suppose that a reader gets preempted for a very long time in the
> > >middle of __srcu_read_lock():
> > >
> > >       int __srcu_read_lock(struct srcu_struct *ssp)
> > >        {
> > >               int idx;
> > >
> > >              idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > >              // PREEMPTED RIGHT HERE
> > >              this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> > >              smp_mb(); /* B */  /* Avoid leaking the critical section. */
> > >                return idx;
> > >       }
> >
> > >Suppose that several SRCU grace periods elapse during that preemption.
> > >
> > >Do you see how that can lead to your SRCU_STATE_SCAN1 early exit?
> >
> > I see,  thank you for your explanation.
> 
> >>>To cement your new knowledge, can you tell me in detail the sequence of
> >>>events, line by line in the code, that would lead to the >>>SRCU_STATE_SCAN1
> >>>early exit?
> >>>
>    
>  Suppose you have the following scenario :
>  ssp->srcu_idx = 0
> 
>               cpu0                                                                                                            cpu1                                 
> 
>  __srcu_read_lock                                                                                              process_srcu
>       idx = READ_ONCE(ssp->srcu_idx) & 0x1;                                                 srcu_advance_state
>             /*idx == 0,*/ by preempt long time                                                               SRCU_STATE_SCAN1
>                                                                                                                                                idx = 1 ^ (ssp->srcu_idx & 1);
>                                                                                                                                                /*idx == 1*/    
>                                                                                                                                                 try_check_zero (idx)== true
>     other task run                                                                                                                  srcu_flip(ssp);   
>                                                                                                                                              /* ssp->srcu_idx == 1*/
>                                                                                                                                          SRCU_STATE_SCAN2
>                                                                                                                                                 idx = 1 ^ (ssp->srcu_idx & 1);
>                                                                                                                                                 /*idx == 0*/
>                                                                                                                                                 try_check_zero (idx)== true
>                                                                                                                                                 srcu_gp_end
>      current task run
>      this_cpu_inc(ssp->sda->srcu_lock_count[idx]);                                       process_srcu
>                                                                                                                                      srcu_advance_state
>                                                                                                                                           SRCU_STATE_SCAN1
>                                                                                                                                                    /*ssp->srcu_idx ==1*/
>                                                                                                                                                     idx = 1 ^ (ssp->srcu_idx & 1);
>                                                                                                                                                     /*idx==0*/
>                                                                                                                                                    try_check_zero == false
>                                                                                                                                                             return
>    
>      do something
>     
>     __srcu_read_unlock
>            /*idx == 0*/
>            this_cpu_inc(ssp->sda->srcu_unlock_count[idx]);

Very good!

If you are interested, you might consider blogging this, whether in
English or your native language.

							Thanx, Paul

>  Thanks
>   Qiang
> 
> > >
> > >                                                        Thanx, Paul
> > >
> > >
> > >PS:  The paper below outlines a similar situation in userspace RCU,
> > >     so feel free to use this paper as a hint.  The paper is in two
> > >    pieces, with the first piece in the first URL and the second in
> > >     either of the last two URLs.
> > >
> > >@article{MathieuDesnoyers2012URCU,
> > > Author="Mathieu Desnoyers and Paul E. McKenney and Alan Stern and Michel >R. Dagenais and Jonathan Walpole",
> > > Title="User-Level Implementations of Read-Copy Update",
> > >journal="IEEE Transactions on Parallel and Distributed Systems",
> > >volume={23},
> > > year="2012",
> > >issn="1045-9219",
> > > pages="375-382",
> > > doi="10.1109/TPDS.2011.159",
> > >publisher="IEEE Computer Society",
> > > address="Los Alamitos, CA, USA",
> > > annotation={
> > >       RCU overview, desiderata, semi-formal semantics, user-level RCU
> > >       usage scenarios, three classes of RCU implementation, wait-free
> > >        RCU updates, RCU grace-period batching, update overhead,
> > >        http://www.rdrop.com/users/paulmck/RCU/urcu-main-accepted.2011.08.30a.pdf
> > >        http://www.rdrop.com/users/paulmck/RCU/urcu-supp-accepted.2011.08.30a.pdf
> > >        http://www.computer.org/cms/Computer.org/dl/trans/td/2012/02/extras/ttd2012020375s.pdf
> > >},
> > >}
