Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4F8C433EF
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 00:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbhKYBAk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236767AbhKYA6j (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 19:58:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C726D610C8;
        Thu, 25 Nov 2021 00:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637801729;
        bh=xdymPQyK7gdFsIQR3HCpcKrt/ANx7OykyFUrbxE2A6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjZ+iAsrXCa3dxljlCRNd/fiDcwzg38jpgN2OgC3HgSrAguMGEmoxcc5V0HgSrX4B
         jPQSOsf7MrGu70W510vc361ReqZ/ZcVFbuqJK/bfRfvWOxaJuePBPaTJn69qwAlSGl
         IuiIYf+Z3HjnVI7WrqE3F/nFmCFRpm9PUuzIJE/hMovCPG+FxYDiyj3W3BOV0eXfC/
         MGJC4MUZAYK9Q4KC1Ln2EjdLCen/V0Bv8f8UjNL8QdoJ8QqmRBGzsBnddGkeNeOXFD
         l7KcmpuTMKcbLgF0ZDC5WBDNlrphwUu8zoKlq+u0gJXejXIHNWSPFsIYP6V8w6Y3zD
         RxHSQgbaQ1+Kg==
Date:   Thu, 25 Nov 2021 01:55:26 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        yury.norov@gmail.com
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Message-ID: <20211125005526.GA490855@lothringen>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-6-frederic@kernel.org>
 <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 24, 2021 at 04:47:20PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 23, 2021 at 01:37:07AM +0100, Frederic Weisbecker wrote:
> > If a user wants to boot without any CPU in offloaded mode initially but
> > with the possibility to offload them later using cpusets, provide a way
> > to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> > the creation of dormant nocb kthreads.
> 
> Huh.  This would have been a use for Yury Norov's "none" bitmask
> specifier.  ;-)

This must be the last missing piece before we can finally support NR_CPUS=0 ;)

> 
> I pulled this one in with the usual wordsmithing.

Thanks!
