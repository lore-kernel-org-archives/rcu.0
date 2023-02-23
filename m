Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFEC61DA4
	for <rcu@archiver.kernel.org>; Thu, 23 Feb 2023 17:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBWRgg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 12:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWRgf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 12:36:35 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99A5D55C0F;
        Thu, 23 Feb 2023 09:36:32 -0800 (PST)
Date:   Thu, 23 Feb 2023 18:36:26 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Julian Anastasov <ja@ssi.bg>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, netdev@vger.kernel.org
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <Y/ekGgkUWAKeGfbO@salvia>
References: <20230201150815.409582-1-urezki@gmail.com>
 <Y/df4xtTQ14w/2m4@lothringen>
 <IA1PR11MB6171CE257AC58265B8B7CC9889AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230223155415.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <44eeb053-addd-263e-90d3-131598cfef6c@ssi.bg>
 <20230223171432.GC2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223171432.GC2948950@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 23, 2023 at 09:14:32AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 23, 2023 at 06:21:46PM +0200, Julian Anastasov wrote:
> > 
> > 	Hello,
> > 
> > On Thu, 23 Feb 2023, Paul E. McKenney wrote:
> > 
> > > > > Not sure if you guys noticed but on latest rcu/dev:
> > > > > 
> > > > > net/netfilter/ipvs/ip_vs_est.c: In function ‘ip_vs_stop_estimator’:
> > > > > net/netfilter/ipvs/ip_vs_est.c:552:15: error: macro "kfree_rcu" requires 2
> > > > > arguments, but only 1 given
> > > > >    kfree_rcu(td);
> > > > >                ^
> > > > > net/netfilter/ipvs/ip_vs_est.c:552:3: error: ‘kfree_rcu’ undeclared (first use in
> > > > > this function); did you mean ‘kfree_skb’?
> > > > >    kfree_rcu(td);
> > > > >    ^~~~~~~~~
> > > > >    kfree_skb
> > > > > net/netfilter/ipvs/ip_vs_est.c:552:3: note: each undeclared identifier is
> > > > > reported only once for each function it appears in
> > > > 
> > > > Hi Frederic Weisbecker,
> > > > 
> > > > I encountered the same build error as yours. 
> > > > Per the discussion link below, the fix for this build error by Uladzislau Rezki will be picked up by some other maintainer's branch?
> > > > @Paul E . McKenney, please correct me if my understanding is wrong. 😊
> > > > 
> > > >     https://lore.kernel.org/rcu/Y9qc+lgR1CgdszKs@salvia/
> > > 
> > > Pablo and Julian, how are things coming with that patch?
> > 
> > 	Fix is already in net and net-next tree
> 
> Very good, thank you!  Is this going into this merge window or is it
> expected to wait for v6.4?

this merge window. 							Thanx, Paul
