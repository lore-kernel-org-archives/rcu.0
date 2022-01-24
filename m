Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB9CC433EF
	for <rcu@archiver.kernel.org>; Mon, 24 Jan 2022 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244734AbiAXRlS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244692AbiAXRlS (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 24 Jan 2022 12:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643046077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLmnh7F+9qnrIKW2UFS2DJy4bOHo/tjVCSEI8rXwkN0=;
        b=RWjTgdtWceEkJ+L44KH9EoWYyn7bCtSsJ9/cEMeHBaBiQaJJboHcI9cTAdS9xFLwGmTjkI
        YMTxuJ9FEz0VSYjXeSVTScN0mRy1d7pt4PeUmFVetYtRyZGK4GAlbULnqhl26pyz8JGMp0
        BnISvC77sOxBwrN/HLMqkn9FQEgQOL4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-bQDFP_YLNUCnG5IN3xiQIw-1; Mon, 24 Jan 2022 12:41:15 -0500
X-MC-Unique: bQDFP_YLNUCnG5IN3xiQIw-1
Received: by mail-qt1-f198.google.com with SMTP id e14-20020ac84b4e000000b002cfbbdf8206so1963488qts.10
        for <rcu@vger.kernel.org>; Mon, 24 Jan 2022 09:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLmnh7F+9qnrIKW2UFS2DJy4bOHo/tjVCSEI8rXwkN0=;
        b=8Goc0QFLG2o5Mh/XVAJ7BTy0IBnKoDQQ3PEds1qfFQjRRVwKFlerH2SEtwHF6H1Kej
         7hs3BwlkJtPlzKFXA3aqzh2wIildAI3EjarZK2rBOUnMOIxhmkahUo7XM6Tj4xoq5NYi
         +PV60lkdV+xkmPDTDubw1TFejYwub5KQ5f5kqkKwO8V6FMcxm8yUJCqDKOQiWxYNHKHa
         T/uyjodyR1rV+lQ3p5MXbP4xDlnCW+vrmPTB8I84Y+L8BPrxsyK+igcTfBOkHHdvR6i7
         ASYVz2saRCr9+lE7mk9dUnJIlHV4c9cAc74qNd6vbNcH31ppgENFN3x6HhCcG54OhJoy
         3BfQ==
X-Gm-Message-State: AOAM53246oh1Z0vpadYP6YYokTFkG5+qgjJy6UAplahCJjdb9uBHO5VI
        HD9RG02LLVoy2c9YCFpFJEfY6oTpUeq+rtlm+dfWTCQZ6tBVHTUkV5X8QVkxs6hGv7JG8eYbOlu
        O8WZHCnD+4cwPZD/+l57FhjktW17S
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr5880998qvc.59.1643046075044;
        Mon, 24 Jan 2022 09:41:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmZ0zoLxqMaj4sgRawFKfYQmeh7BxLZQUfotyGdGqOmghwyprTfohZ9jYN68ECfTUFCiv5VLMuukYTQwYO+9A=
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr5880983qvc.59.1643046074838;
 Mon, 24 Jan 2022 09:41:14 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
In-Reply-To: <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 24 Jan 2022 12:41:04 -0500
Message-ID: <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> >
> > Hi,
> >
> > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > >
> > > > I see also:
> > > >
> > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > >
> > >
> > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > >
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index cb1f4351e8ba..a164089abec4 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > >  #ifdef MODULE
> > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > >         is_static struct srcu_struct name;                              \
> > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > >                 __section("___srcu_struct_ptrs") = &name
> > >  #else
> > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > >
> >
> > I tried it and yes it will fix the issue and introduce another one
> > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > unused ("-Wunused-const-variable").
> > I added a __maybe_unused after the introduced is_static and it seems
> > to fix the introduced issue, now it compiles and sparse is happy. I am
> > not sure if this is the right fix?
>
> it is obviously unused, but it has something to do with
> "__section("___srcu_struct_ptrs")" and during module loading it, I
> suppose, srcu tries to access it to find whatever needs to be
> registered?

Sorry, but if this is true then it can't be declared as static... and
we are at the beginning again.

- Alex

