Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D59C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 17:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCBD217D9
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 17:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jytRn0Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbgFRRZN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbgFRRZM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 13:25:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D931C06174E;
        Thu, 18 Jun 2020 10:25:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so8221016ljv.5;
        Thu, 18 Jun 2020 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDul8Qh0CB358ogHpHF9Y6TUm3gZ3Awnu5uEsfMvzXo=;
        b=jytRn0ZkcCvASYLtuAiqO9TmsCYp2QNKntI0YdNmcgXJwlmGLswJemHy2QXPvAcih4
         pD8+g+itRn+Ctf2uJagLKgIMldVzgnPVDWJ+L3RzpwZJbpEaoEoMQlJdUpka7cimkl5K
         22IRvWru1/LyN7cgSww3ZBFwkQ/c/3G8eDYLfA9Z0G0KEioP/FueqqBL4/If1LTa0yfg
         sWZ98NCBnDO11r9wD1v6OfoLdojloPVlkYCHi3qfjsbuekNO7zGUhmx73/aOCl7rKUJj
         WbAxErDCxHChAFUAwPxCPf1v9wmZS4rFAADUpxZurdyBg/vp+SEkPKmBN/QwsXYI97hZ
         WLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDul8Qh0CB358ogHpHF9Y6TUm3gZ3Awnu5uEsfMvzXo=;
        b=JRrivbpbnRPGgaI4/dzf7anFYrTW9je+qMwR3wvYGMvVTUm8y/r3VqKlfbjxya1ExE
         IIwW+ZhnKQr+ot+Eeyo5pUhi3vO4UYj4ZveK06Fof/R8np2h5IEXTGA7xyp0FYnOnD3y
         H6bIuWh8GVg5vBIxQvUfiZbrKOqQQUdtCnmmQcZWos68qpTT1xDXeMeCXUIit05oG8ft
         XBYG+3JgchNjfyYNIRlSsSjAPbCcx13KtvBpwt81O+o6Tmoq2tsBVUXj/ggU5cxgUbe1
         e+vqRUysMfs52gfDvJrssD4+pJxYQRTPha9+ZQsEVIFzH2PMi4O8xR9bZBsZ/fEbUR2+
         g5CA==
X-Gm-Message-State: AOAM5325C0+SGDA5bPrSqOfvCLkKz3eEstlrU1GYM4zfenvRaprBddEI
        88mMMB851boljoI764WG8m4=
X-Google-Smtp-Source: ABdhPJyEksYH81Qt/PCV8lSVyrUxAJi2V+HPAy2DPTvZAwNg9dIvImJ1AnOc8JkDn8zCVvJwpRi+ug==
X-Received: by 2002:a05:651c:50d:: with SMTP id o13mr3061382ljp.181.1592501110117;
        Thu, 18 Jun 2020 10:25:10 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s20sm846671ljs.36.2020.06.18.10.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:25:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 19:25:04 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618172504.GA14613@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617234609.GA10087@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > +	// Handle two first channels.
> > +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> > +		for (; bkvhead[i]; bkvhead[i] = bnext) {
> > +			bnext = bkvhead[i]->next;
> > +			debug_rcu_bhead_unqueue(bkvhead[i]);
> > +
> > +			rcu_lock_acquire(&rcu_callback_map);
> > +			if (i == 0) { // kmalloc() / kfree().
> > +				trace_rcu_invoke_kfree_bulk_callback(
> > +					rcu_state.name, bkvhead[i]->nr_records,
> > +					bkvhead[i]->records);
> > +
> > +				kfree_bulk(bkvhead[i]->nr_records,
> > +					bkvhead[i]->records);
> > +			} else { // vmalloc() / vfree().
> > +				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> > +					trace_rcu_invoke_kfree_callback(
> > +						rcu_state.name,
> > +						bkvhead[i]->records[j], 0);
> > +
> > +					vfree(bkvhead[i]->records[j]);
> > +				}
> > +			}
> > +			rcu_lock_release(&rcu_callback_map);
> 
> Not an emergency, but did you look into replacing this "if" statement
> with an array of pointers to functions implementing the legs of the
> "if" statement?  If nothing else, this would greatly reduced indentation.
> 
>
> I am taking this as is, but if you have not already done so, could you
> please look into this for a follow-up patch?
> 
I do not think it makes sense, because it would require to check each
pointer in the array, what can lead to many branching, i.e. "if-else"
instructions.

Paul, thank you to take it in!

--
Vlad Rezki
