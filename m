Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83743C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5357720734
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 17:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlA7vQVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFRR43 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgFRR42 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 13:56:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02071C06174E;
        Thu, 18 Jun 2020 10:56:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so8312200ljh.13;
        Thu, 18 Jun 2020 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hgEY9YL3J/pKkRYUMahi1oLwyNouWGOcWOKShQWynNc=;
        b=tlA7vQVv5Scg4QNwojArqYul7A5kJgYGKq7Ugf1JjNzSnocplvmiPT3lrh5xGGoLVW
         cezAzQfr3n03TQjr68p+ylDrMDuNvcv/HR886KOR5UsWYjdqt0ET42vdFeO43+Jgeipt
         ML5cDVbqEjhT8YRZBeY4QwnIqB8niUMq5orUASwBXgyCtdTSu3or48ugdRXh5Q1HTYWZ
         HOvFFM+nPzxzgw7DjcbbtO9aMKSDgRK1ZQe8OYJufsgC0ra8bClYTeiIC+4pC6Pgdgp5
         NTBjzbRUiigbW3fpxIOug5nMhqD633zDq48kP35jGijTIp5inJmqaMivZ5y1Y7Cy7YH0
         yhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgEY9YL3J/pKkRYUMahi1oLwyNouWGOcWOKShQWynNc=;
        b=ow9RXCA9NqhCejP4/o2QE8fTnmJ9xhatvb6AA7OZ+Ac1mPOVkQGrhHUqjlUA1KAX6G
         IzFunXklScCQ0z4OCybRfcrQkkNx1dglwr/UVzluLizXuym8afpfpVSHTccrEM7LyOMe
         pB+OUIYfH6iGfmsxrnauJ7AQsSq5lpcR7/kgbdx1WP/WS6IUgvcyw6ScIa32SPQE88P2
         dMcB0IngSFUhGxD5BwU7w6q5ahL9q6INw0cBzUxOdKmQE4YHEm6X+GRcn0uI9ASnAffu
         8Xlb/252N0r6AKZmt9/71yySl2krQ6A5gJLzlakKNBfU5Ko5uCmS5EG+KAhNcDsFc585
         boUw==
X-Gm-Message-State: AOAM531D3M89qeEVU5nQki5sUKEeTZNHXhrevd+O5pfSnvuNjvKsz2xS
        Jk5jZt/BYwp+y4ObOmJqBD8=
X-Google-Smtp-Source: ABdhPJxewL4d2SFKZDdYq8LkLi0kuEt4pcUh152NCFxOxhuEZQcUamPYu9xoSQwEEuFTX7Rlm5X1kA==
X-Received: by 2002:a2e:6c07:: with SMTP id h7mr3097280ljc.125.1592502986338;
        Thu, 18 Jun 2020 10:56:26 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v20sm269849lfe.46.2020.06.18.10.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:56:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 19:56:23 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618175623.GA14865@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618172504.GA14613@pc636>
 <20200618173206.GS2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618173206.GS2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 10:32:06AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 07:25:04PM +0200, Uladzislau Rezki wrote:
> > > > +	// Handle two first channels.
> > > > +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> > > > +		for (; bkvhead[i]; bkvhead[i] = bnext) {
> > > > +			bnext = bkvhead[i]->next;
> > > > +			debug_rcu_bhead_unqueue(bkvhead[i]);
> > > > +
> > > > +			rcu_lock_acquire(&rcu_callback_map);
> > > > +			if (i == 0) { // kmalloc() / kfree().
> > > > +				trace_rcu_invoke_kfree_bulk_callback(
> > > > +					rcu_state.name, bkvhead[i]->nr_records,
> > > > +					bkvhead[i]->records);
> > > > +
> > > > +				kfree_bulk(bkvhead[i]->nr_records,
> > > > +					bkvhead[i]->records);
> > > > +			} else { // vmalloc() / vfree().
> > > > +				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> > > > +					trace_rcu_invoke_kfree_callback(
> > > > +						rcu_state.name,
> > > > +						bkvhead[i]->records[j], 0);
> > > > +
> > > > +					vfree(bkvhead[i]->records[j]);
> > > > +				}
> > > > +			}
> > > > +			rcu_lock_release(&rcu_callback_map);
> > > 
> > > Not an emergency, but did you look into replacing this "if" statement
> > > with an array of pointers to functions implementing the legs of the
> > > "if" statement?  If nothing else, this would greatly reduced indentation.
> > > 
> > >
> > > I am taking this as is, but if you have not already done so, could you
> > > please look into this for a follow-up patch?
> > > 
> > I do not think it makes sense, because it would require to check each
> > pointer in the array, what can lead to many branching, i.e. "if-else"
> > instructions.
> 
> Mightn't the compiler simply unroll the outer loop?  Then the first
> unrolled iteration of that loop would contain the then-clause and
> the second unrolled iteration would contain the else-clause.  At that
> point, there would be no checking, just direct calls.
> 
> Or am I missing something?
> 
If we mix pointers, then we can do free per pointer only. I mean in that
case we will not be able to use kfree_bulk() interface for freeing SLAB
memory and the code would converted to something like:

<snip>
while (nr_objects_in_array > 0) {
    if (is_vmalloc_addr(array[X]))
       vfree(array[X]);
    else
       kfree(array[X]);
}
<snip>

> > Paul, thank you to take it in!
> 
> Thank you for persisting!
> 
Welcome :)

--
Vlad Rezki
