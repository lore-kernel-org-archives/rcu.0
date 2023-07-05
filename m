Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF84CEB64DA
	for <rcu@archiver.kernel.org>; Wed,  5 Jul 2023 12:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGEMpG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 08:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGEMpF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 08:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0192E70;
        Wed,  5 Jul 2023 05:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC456155A;
        Wed,  5 Jul 2023 12:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F033C433C8;
        Wed,  5 Jul 2023 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688561103;
        bh=GU1upNTXjEZ+94qjAGPjnfY7h27lWej95MTNM7ZB0o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ji66A5vKEMs2G6H+4FECRzZb5P8TWN+6djfRgbxtTeC7Eo2Y9hmIyipXdLKfWOGeR
         /MdNYGel3VZ9XSygP/4N884lDMVgJHah8nQHT5MJCtl4Xk9ohgCD40kQBRt4ip4z3y
         gSQm84HB3+Ap4T377AA1pgC/2g8AoTFquXluUwJc1GdFkhwbHz53H2fFdnKC9yLM3m
         nHO0PI64uEEJgJ2lMvUlVAelHnjiq2eE7UfbJqe7UacBRUtHfdKmhVePMlcHB69kO7
         ZFsmTkuEH3Y2z+SYtEWi6iroFUMGmKXrVd53WTIUjxUf/RrFboo8T7VKUzEwRBo8Sn
         frJ8gv/7j1S4A==
Date:   Wed, 5 Jul 2023 14:45:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 4/9] rcu: Introduce lazy queue's own qhimark
Message-ID: <ZKVlzOuQ0HyhSZ3L@localhost.localdomain>
References: <20230531101736.12981-1-frederic@kernel.org>
 <20230531101736.12981-5-frederic@kernel.org>
 <20230603012338.GA2795276@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230603012338.GA2795276@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Sat, Jun 03, 2023 at 01:23:38AM +0000, Joel Fernandes a écrit :
> On Wed, May 31, 2023 at 12:17:31PM +0200, Frederic Weisbecker wrote:
> > The lazy and the regular bypass queues share the same thresholds in
> > terms of number of callbacks after which a flush to the main list is
> > performed: 10 000 callbacks.
> > 
> > However lazy and regular bypass don't have the same purposes and neither
> > should their respective thresholds:
> > 
> > * The bypass queue stands for relieving the main queue in case of a
> >   callback storm. It makes sense to allow a high number of callbacks to
> >   pile up before flushing to the main queue, especially as the life
> >   cycle for this queue is very short (1 jiffy).
> 
> Sure.
> 
> > 
> > * The lazy queue aims to spare wake ups and reduce the number of grace
> >   periods. There it doesn't make sense to allow a huge number of
> >   callbacks before flushing so as not to introduce memory pressure,
> >   especially as the life cycle for this queue is very long (10
> >   seconds).
> 
> It does make sense as we have a shrinker, and it is better to avoid RCU
> disturbing the system unwantedly when there's lots of memory lying around.
> 
> > 
> > For those reasons, set the default threshold for the lazy queue to
> > 100.
> 
> I am OK with splitting the qhimark, but this lazy default is too low. In
> typical workloads on ChromeOS, we see 1000s of callback even when CPU
> utilization is low. So considering that, we would be flushing all the time.
> 
> Eventually I want the mm subsystem to tell us when flushing is needed so we
> could flush sooner at that time if really needed, but for now we have a
> shrinker so it should be OK. Is there a reason the shrinker does not work for
> you?

So you mean dynamically adapting the lazy qhimark on top of shrinker calls,
right? That would make sense indeed.

Thanks.
