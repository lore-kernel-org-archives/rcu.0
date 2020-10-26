Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1989EC4363A
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 00:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F54223EA
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 00:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603673462;
	bh=AcS6PXAs1RZnOH5u61roMZctAoVNQhD1wmdMA5GBS50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g/Vtc5iET3Im2ukBGu98RUz8W4JeFAh03/HBKyZqtEOExcmfIZHmDXnFyjy5GzYnD
	 RPKH/hMAjzBnOQTyBtEWJefmkqXCeS3nc1PRvDc41LJ6YYmivJ9eBBgg1LI+wsvinQ
	 K6p0DhmGSaW+aKndHIqoGfVMju6tGuUH1Wg/qy/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420934AbgJZAvC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 25 Oct 2020 20:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393433AbgJZAvC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 25 Oct 2020 20:51:02 -0400
Received: from localhost (unknown [176.177.109.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C2F2225C;
        Mon, 26 Oct 2020 00:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603673461;
        bh=AcS6PXAs1RZnOH5u61roMZctAoVNQhD1wmdMA5GBS50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0eBEDMPe64ba02woGUtqblEyg57p7Ytfubf2gkufw+aSENX3XiHywL1o3TSncWKc7
         weaJD6R+wHyFj+UiECF5OFy+wqWNFlNMT7WWHXdfLqLugCHpy3HYCTtMygYZV7Jsf+
         DEVMhDZIk1/ckoWiurGfLv41YtI+ISw2i6Xb27N8=
Date:   Mon, 26 Oct 2020 01:50:58 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v8 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201026005058.GB104441@lothringen>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021190813.3005054-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 21, 2020 at 03:08:09PM -0400, Joel Fernandes (Google) wrote:
>  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  {
> -	int i;
> +	int i, j;
>  
>  	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
>  	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> @@ -487,6 +508,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
>  		return false;
>  
> +	/* Accounting: everything below i is about to get merged into i. */
> +	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
> +		rcu_segcblist_move_seglen(rsclp, j, i);
> +

Can you perhaps reuse the below loop to move the seglen?

Thanks.

>  	/*
>  	 * Merge all later callbacks, including newly arrived callbacks,
>  	 * into the segment located by the for-loop above.  Assign "seq"
