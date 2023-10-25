Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943BDC0032E
	for <rcu@archiver.kernel.org>; Wed, 25 Oct 2023 15:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjJYPNk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Oct 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344496AbjJYPNg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Oct 2023 11:13:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDBD42;
        Wed, 25 Oct 2023 08:13:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7291EC433C8;
        Wed, 25 Oct 2023 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698246810;
        bh=BoLlPz5gkAu/xRvuEzDPa0TMWiFLeA8SCGHV/kEncmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTIWkabIrDQ+RRNndW3Ff9MBbxXmD0+xAjJGrsY/fQolECJIsQVv99FP/DZ0uLC3h
         vZcaXvC0J7iKmdujSabgt1bClVAyhwAfrDN3ipo8Zgp654GPhvWyRiE9DLOPR2Nz49
         cW/xAEKtr66MZA5x+i6Qk94KKiIlmVYlpVH9sMVft1Y2LS4igh3wmG8s4ZsldYyGOR
         +NT6darX0zSQ6fq08SMEcYdmncQQ7v9RUH0MQZRDlN/Sme8tKMbEePHZ165S8amLtS
         22/pYg9pdZMXkYSgIbliArPeiDfXSo+YW3u8kZ3k1Q/hC1mBMe27QnhsjQB+ZPb7As
         kUYCvPFmPJZCA==
Date:   Wed, 25 Oct 2023 17:13:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZTkwl0bzTTCy8g5N@localhost.localdomain>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025140915.590390-2-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Wed, Oct 25, 2023 at 04:09:13PM +0200, Uladzislau Rezki (Sony) a écrit :
> +/*
> + * Helper function for rcu_gp_cleanup().
> + */
> +static void rcu_sr_normal_gp_cleanup(void)
> +{
> +	struct llist_node *head, *tail, *pos;
> +	int i = 0;
> +
> +	tail = READ_ONCE(sr.wait_tail);
> +	head = llist_del_all(&sr.wait);

This could be llist_empty() first to do a quick
cheap check. And then __llist_del_all() here because
it appears nothing else than gp kthread can touch sr.wait.

> +
> +	llist_for_each_safe(pos, head, head) {

Two times head intended here? There should be some
temporary storage in the middle.

> +		rcu_sr_normal_complete(pos);
> +
> +		if (++i == MAX_SR_WAKE_FROM_GP) {
> +			/* If last, process it also. */
> +			if (head && !head->next)
> +				continue;
> +			break;
> +		}
> +	}
> +
> +	if (head) {
> +		/* Can be not empty. */
> +		llist_add_batch(head, tail, &sr.done);
> +		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);

So you can have:

* Queue to sr.curr is atomic fully ordered
* Check and move from sr.curr to sr.wait is atomic fully ordered
* Check from sr.wait can have a quick unatomic unordered
  llist_empty() check. Then extract unatomic unordered as well.
* If too many, move atomic/ordered to sr.done.

Am I missing something?
