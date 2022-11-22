Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB72FC4332F
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 01:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKVBiA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiKVBiA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Nov 2022 20:38:00 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8137A3422;
        Mon, 21 Nov 2022 17:37:58 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y13so12967554pfp.7;
        Mon, 21 Nov 2022 17:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OglGzgpYMyqj8QLL99cHzcyrtXf8AaVJLvZ6MUdXVbM=;
        b=DMZCQQU6xzfha3oRwrG/+v6K3YeyvSHyIguZJUnk8JqHaetRW6TjzBQ/PnIWLZhncb
         1awxrf+ChpGwbGqk8lqyUldWtsThOZkUUbcKB86w5whDLwfNS6KcpXf1E78ihksY8iaB
         ST7tNVluqG9NU0iXimFDE5srH7vyke7+cNoj5B9v8XInspfnM15yuG0mH3KVrGNnNM3D
         bL2QfxOofnnMIphXunC+uZHe5C0mL1TfTl/bniKdu2/FBvsU1CURG3zen2oMD4DLiS+4
         a2jYwVRJAoIWUFFHXB9a1Qv+wCdX3IReMf0qgTDFKiZcTBjiMXrp96Cl/JSStksVlFE4
         CAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OglGzgpYMyqj8QLL99cHzcyrtXf8AaVJLvZ6MUdXVbM=;
        b=HuQLKsUHmC/5z4V1Iget7h0ZfH3fZwyZZ6uJkW+r7Rhvw/O+OzCdI2sa9wpwWCWpin
         g18GNF73SttPtxWyyJ6MPAy5gjW7q7ukTM34xeyoAWCxnNKxNn2m8zcshwmzkN0QV8Xb
         E6rJpMDrpl4fyVXRDXBeRQcK92g5D2sA0rKYId/oBbT2mre2DhEYi2jzPDlDaxIXG2qc
         pTkqSVe/wGRRWELhsM1SsG2nEop+2If0E/5Mo8F5YRc5Ol3WumpQK8UcdtykNz3Rql9K
         ml9icPkushwxSSvPNLwEjHJBc9i6m6NQFuIzuYfwyvW/k5XlbQ3qaDBl/y+QOS7EoZNT
         oNJA==
X-Gm-Message-State: ANoB5plTpUliGl507TnIppdAhmnTRf7Pkz3FXpIiE/Gem+ZQFn4yl5Gf
        T4ef5RTxEhB8eErXQkjb4Dk=
X-Google-Smtp-Source: AA0mqf7fvIADqXeFH5nRswqo5AfA2P/FscS26XdKuh6ZX/1pWBoUcCzu8yfjpafSEduYL0FEDa1bJw==
X-Received: by 2002:a65:694e:0:b0:474:6749:407d with SMTP id w14-20020a65694e000000b004746749407dmr1311330pgq.425.1669081078088;
        Mon, 21 Nov 2022 17:37:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b0020ae09e9724sm8319928pjb.53.2022.11.21.17.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:37:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Nov 2022 15:37:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 rcu 13/16] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y3wn9AK1XxEZIIFw@slm.duckdns.org>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-13-paulmck@kernel.org>
 <Y3whScgTs0FgrVtY@slm.duckdns.org>
 <20221122012357.GV4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122012357.GV4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 21, 2022 at 05:23:57PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 21, 2022 at 03:09:29PM -1000, Tejun Heo wrote:
> > On Mon, Nov 21, 2022 at 05:04:18PM -0800, Paul E. McKenney wrote:
> > > And another call_rcu() instance that cannot be lazy is the one
> > > in queue_rcu_work(), given that callers to queue_rcu_work() are
> > > not necessarily OK with long delays.
> > 
> > So, this is fine but another thing we can do is propagating the distinction
> > through the workqueue interface so that the the choice can be made by
> > workqueue users. Would that make sense?
> 
> It might well!  My thought was to wait to suggest that until we found a
> real-life case where this was needed, but I have no objection to being
> proactive here.

Oh yeah, I'm completely fine either way too.

> But the hard part...  Thought for a good name?  ;-)

If we go with a separate interface, yeah, _flush would be confusing for
workqueue. Maybe _quick or _hurry? Hmm... it'd be nice to keep the suffix
consistent with RCU. What's the relationship with
synchronize_rcu_expedited()? Would using _expedited be confusing?

Thanks.

-- 
tejun
