Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA13C47247
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EFB20721
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 19:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO208hOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEDTve (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDTve (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 15:51:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2610C061A0E;
        Mon,  4 May 2020 12:51:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f18so10939494lja.13;
        Mon, 04 May 2020 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J91U/M/ZEHah2SHGhHU5m9wEosn67ktuzmfNHVCfVJM=;
        b=dO208hOUAs5fuz+vEGGNXmVX8Fu9D62O9DqTcWUINtzEuVAgJxJbFKOE2GLym3cnmC
         aFIWpX7Vxo9YaQlneZmRXKtY7LLmxtYRRiP9e68pPrYtBPCbnBB9uqHfeieFhDHq3tta
         Lb91czUIIX6XzTh/lOyEyfdzYEduZpzmi2YzKc8vO3Myp9FiT5wgHyIi8c0srCvVPkMC
         Z7zGCZFRCA3aru4JTFp9fhgeJDYa/49Lq3F+cEaopH9YM2YXDOC0EA8UWAiRqiLcciJ4
         u4iFyFJ9YsWv0rPifCQ+TGOsmp3H7BPayIFeYicXPQ8MhwSqAU+h68B3royW0iCxcdRo
         rEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J91U/M/ZEHah2SHGhHU5m9wEosn67ktuzmfNHVCfVJM=;
        b=X4IKdDw+hrTMCHPl+MWMC+Dabdx0hAuK48B/RAnKjwQFHldvPCcnDu6T6g7Lw/OliD
         niEoIRu6nyLGiGViFrnfqDsPJNtzTXDTiAliTfvJUvTLi4bTcqhJzFc+dqSPcip4Xrs3
         5/7qy36GVwsXMQVGBvORwIGxVXgGViUSpejrRbhBABYB22H5i0WxxK8oDC4cRBBxHr6M
         RD5eFL/LNfpTnz4HAzyboe1t1N8OjAq7HjPs19Z0NJrcAvAdMdFD6bHnkyI/RTsBDSFy
         0HGKSRGGAzbiMVrb/df1maq5bjXf0e6Fa8NhtGkhN12W8/tJGSmN1bttNGMto8OA6J9Y
         zgWw==
X-Gm-Message-State: AGi0PuaWyQd1vINZrOyMATbVUHSX3Op45fRrmlCTyxP6t/YQKX54PLwb
        jbgSSC1haNs9MS3M16rW8r4=
X-Google-Smtp-Source: APiQypKdqsxPo5O8L2/GpPQRr2NHGKK2RbQPb8x+UpFQVrNQldSNws+cMDCcu9Tak8RSHfCGZyR7qQ==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr11093873lji.117.1588621892146;
        Mon, 04 May 2020 12:51:32 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m23sm9065936ljb.87.2020.05.04.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:51:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 21:51:28 +0200
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504195128.GA21830@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72>
 <20200504174822.GA20446@pc636>
 <20200504180805.GA172409@google.com>
 <20200504190138.GU2869@paulmck-ThinkPad-P72>
 <CAEXW_YQmrfbaDocsc7bLULRR1yUv4=MMMEw3b0s1mXM8sEVVzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQmrfbaDocsc7bLULRR1yUv4=MMMEw3b0s1mXM8sEVVzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > Since we don't care about traversing backwards, isn't it better to use llist
> > > for this usecase?
> > >
> > > I think Vlad is using locking as we're also tracking the size of the llist to
> > > know when to free pages. This tracking could suffer from the lost-update
> > > problem without any locking, 2 lockless llist_add happened simulatenously.
> > >
> > > Also if list_head is used, it will take more space and still use locking.
> >
> > Indeed, it would be best to use a non-concurrent singly linked list.
> 
> Ok cool :-)
> 
> Is it safe to say something like the following is ruled out? ;-) :-D
> #define kfree_rcu_list_add llist_add
> 
In that case i think it is better just to add a comment about using
llist_head. To state that it used as a singular list to save space
and the access is synchronized by the lock :)

IMHO.

--
Vlad Rezki
