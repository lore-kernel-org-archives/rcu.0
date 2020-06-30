Return-Path: <SRS0=ktYI=AL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97B8C433E1
	for <rcu@archiver.kernel.org>; Tue, 30 Jun 2020 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB642074D
	for <rcu@archiver.kernel.org>; Tue, 30 Jun 2020 17:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjY1jjdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgF3Rqy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgF3Rqx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jun 2020 13:46:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB00C061755;
        Tue, 30 Jun 2020 10:46:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so23558703ljm.11;
        Tue, 30 Jun 2020 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tjMV2HhxwqIY48F0IP3MOiKFidan1PF9zaHZx5HX7l0=;
        b=tjY1jjdEVyJZGgANPC64TKpHUZrkSS8EEBBY/YSYskUqJ4iHiJyvY/SRKdbUQ+i8A6
         mKZGquZKcCYFChv95JDvgtkN3ZV/xibcDqKYEEHIpMJi/A6cAJZGE6pZhE171nGMtmAA
         nodVM9EiODNeIbtgN3HbrGNAFmMg6N/7B6AzBwFaweyZLIhRUFG+yAwcZWD13JLlh+i0
         OZ1CEWk/Wj8zu1vB4nlqcy7Xn1NsxZjROarkiYk+/vU/ui4t6L9I0QuT/GLPP4zUT4cf
         ZsQtGTxKQOVJoHF5wbc0na/+t70V/horF7+xmrRSJ+LCxEtZNCscsWvKeg5fkcmngreJ
         JhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tjMV2HhxwqIY48F0IP3MOiKFidan1PF9zaHZx5HX7l0=;
        b=EWI5fQpaxAaujw/K+alYLCcPAVae6BxmveHPcs1us9GsKT4GcK2ArKl5fZducDhvHk
         ss9/Q4/PdNK7NV47tuAjoSp6T/pacvuIQqscAVKSl7f9nc2lt3/gFBGHWC7lRfFdAsd1
         bL1o9nKlnBQ+MEXZC+8KagjTCvsea5vr3THNFzckBeOf4PV68XaiEBoaAB7yWUP18Yx/
         UmAr3oSlzDeKliaWa0q4ChDxK0pIiqXOGaEGYLDSmGEEMuuyvItJgGj7GPY/7c15ewT/
         zOAXxDQJcflsnp6HblGVxKyYk7Ba54iFN0uaCGOWAjEnA3nHKxs+l4ODHCBVvDKEFqWw
         V7UQ==
X-Gm-Message-State: AOAM533Cwx9bCXDzDDy3J5lpcLyIDCEY8v1u/nO+rvHCKH2YWGTcqUca
        Ppz5UPbVPXLWegLzmWnFHIbs1ScTaw+bhQ==
X-Google-Smtp-Source: ABdhPJyeD0L2OQDPsATlLehiaJUOlO6qfctubWWbNJHqTUbySuntBVH0jItLh5nWGXKBUGu1EU7PZw==
X-Received: by 2002:a2e:9b94:: with SMTP id z20mr9220985lji.404.1593539211578;
        Tue, 30 Jun 2020 10:46:51 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y24sm1042122lfy.49.2020.06.30.10.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:46:49 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 30 Jun 2020 19:46:47 +0200
To:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        vbabka@suse.cz, mhocko@suse.com
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200630174647.GA27057@pc636>
References: <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
 <20200618203557.GB16976@pc636>
 <20200618203821.GU8681@bombadil.infradead.org>
 <20200618211709.GA17263@pc636>
 <20200618213427.GV2723@paulmck-ThinkPad-P72>
 <20200619154652.GA19990@pc636>
 <20200619162555.GJ2723@paulmck-ThinkPad-P72>
 <20200622190406.GA3787@pc636>
 <20200622195329.GN9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622195329.GN9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 22, 2020 at 12:53:29PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 22, 2020 at 09:04:06PM +0200, Uladzislau Rezki wrote:
> > > > > 
> > > > > Very good.  When does kfree_rcu() and friends move out of kernel/rcu?
> > > > > 
> > > > Do you mean to move the whole logic of kfree_rcu() from top to down to mm/?
> > > 
> > > I do mean exactly that.
> > > 
> > > That was my goal some years back when Rao Shoaib was making the first
> > > attempt along these lines, and it remains my goal.  After all, if this
> > > effort is at all successful, the coupling between kfree_rcu() with
> > > slab/slob/slub will become much tighter than that between kfree_rcu()
> > > and RCU.
> > > 
> > > There will need to be some additional RCU APIs used by kfree_rcu(),
> > > for example, something to tell RCU how many blocks are awaiting a
> > > grace period.  But these are narrow and easily defined APIs.
> > >
> > I also think that k[v]free_rcu() should reside somewhere under "mm/".
> > Currently they are defined as macros under "linux/rcupdate.h". So i
> > am not sure if definitions should stay there or moved also.
> 
> I am not as worried about the high-level macros as I am about the code
> that does the bulk of the work, but they should still move as well.
> Otherwise, changes involving both the macros and the underlying
> implementation are harder than needed.
> 
> > Implementation of the k[v]free_rcu() is under rcu/tree.c and for tiny
> > variant is under rcutiny.h. It can be moved to the mm/slab_common.c
> > or independent files can be created. I think, mm people should consult
> > what is the best way to go :)
> > 
> > Any thoughts on it?
> 
> I don't have any opinion on exactly where in mm the underlying
> implementation code should go.  You suggestion of mm/slab_common.c
> seems fine to me.  ;-)
> 
OK :)

Then i would like to hear an opinion from the "mm" people where
kfree_rcu() and friends could potentially be moved.

Matthew, Michal, Vlastimil could you please share your view?

Thanks!

--
Vlad Rezki
