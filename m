Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7611C2D0E4
	for <rcu@archiver.kernel.org>; Thu, 12 Nov 2020 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D62022201
	for <rcu@archiver.kernel.org>; Thu, 12 Nov 2020 20:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr++j4Hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKLUPv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKLUPu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Nov 2020 15:15:50 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E532C0613D1
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2020 12:15:50 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id m65so5015383qte.11
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2020 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=EqMuTSW58RZXHOA/mbiyiZHH2agbzTL+tpe5Q2IMYoQ=;
        b=jr++j4HbnsM2x5aD/w+fZG2z3ZUuZ3VnPeXIs5Be3YAVmrurWcNSw3MGC/iiHTkq/P
         cU2gIb/HXQ1i4zooFECnOUADS9MYXN5IsKN5/QcekeqJFLlNhzdgWw8LQ1SoipVkA4N7
         vZaTjRV6NbtuoU2J09g0NNeZShIfV+Int8NGnavKOZkYDKNzIfpnBNn7yaoUCLGvu/kr
         owwLf1D54P1nj6+gGoEFojYcu6UREnYS8VG5OVUS3w9u2S88z2pDmQhoS6zJVXTWHxHQ
         GVLx3j2WjzOpgO/QnAwFAtt+uc1EG+vHHEcqM3P6oMmkwkdLuDqDJ+To94wNn1XcM33T
         MA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=EqMuTSW58RZXHOA/mbiyiZHH2agbzTL+tpe5Q2IMYoQ=;
        b=tUIkm/mqQ1hpVZ/t/Ze3NjAISukSjQ7sJk/TnmyL6lIg9pirEzY6GwY5xh/L6dp9nD
         gOf5E2xW3SVFco98y4SFT3geQwDSKgOaYY9y9jaHnkkkigdCT62XBk80haycA5KxQJgZ
         sua3DWVWIoBO1BEObP8nqxsH+J3fqS7SyG0AD9MS5gG7MyW5/ajBRqo20EKZIgcgXo3O
         3+ve03mwOkC+1n8F5tYR/R4faKXrn3ACz9WF4Ggw0ipns7mIEsmNFAReKidWwE5kAeUA
         NblA/W2kSj35Oy1Ol6QdA9a6P59dxf2r7olynyZRNosh0KSYWy8hrQMls5DEh9R9S3T0
         Tyaw==
X-Gm-Message-State: AOAM533Lrb6AHKPsb0k29zDMD+5efdZSOFVQy/rN0aIWyt7bJiacPgkS
        7yi9JC0KNKpGW0u4ZQtKww==
X-Google-Smtp-Source: ABdhPJzVngJ7+9uwATl6vvuA7q3HFLMUHb3fM0mziHXyu4wF0to6Vnr6A6VtAiVkdat/R0XVKIeZ7Q==
X-Received: by 2002:ac8:7c9a:: with SMTP id y26mr897828qtv.287.1605212149587;
        Thu, 12 Nov 2020 12:15:49 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id c12sm5140935qtx.54.2020.11.12.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:15:49 -0800 (PST)
Date:   Thu, 12 Nov 2020 15:15:47 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: SRCU question
Message-ID: <20201112201547.GF3365678@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi to Paul & the rcu mailing list,

I've got a problem I'm trying to figure out if I can adapt SRCU for.

Within bcachefs, currently struct btree obects, and now also btree_cached_key,
aren't freed until the filesystem is torn down, because btree iterators contain
pointers to them and will drop and retake locks (iff a sequence number hasn't
changed) without holding a ref. With the btree key cache code, this is now
something I need to fix.

What I plan on doing is having struct btree_trans (container for btree
iterators) hold an srcu read lock while it's alive. But, I don't want to just
use call_srcu to free the btree/btree_cached_key objects, because btree trans
objects can at times be fairly long lived and the existing code can reuse these
objects for other btree nodes/btree cached keys immediately. Freeing them with
call_srcu() would break that; I could have my callback function check if the
object has been reused before freeing, but I'd still have a problem when the
object gets freed a second time before the first call_scru() has finished.

What I'm wondering is if the SRCU code has a well defined notion of a clock that
I could make use of. What I would like to do is, instead of doing call_srcu() to
free the object - just mark that object with the current SRCU context time, and
then when my shrinkers run they can free objects that haven't been reused and
are old enough according the the current SRCU time.

Thoughts?
