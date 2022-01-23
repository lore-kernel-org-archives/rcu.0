Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BC5C433FE
	for <rcu@archiver.kernel.org>; Sun, 23 Jan 2022 18:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbiAWSnF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 23 Jan 2022 13:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240132AbiAWSmG (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 23 Jan 2022 13:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642963325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cY1U+lDZEduaUwZDUPPFY/UPA4Nbu9quyT81CXEx4PE=;
        b=HvVLQmQidGjOBF0JntWxCmqZp4PAvN17jypkrI5lCT2u1CCb1MBMctnpCK5g9qa8dJy/3F
        I0lRYYHjHEDkQiYhRnOwT/OxAm/7ux3dM2zagq7pEy5VNV+JgrFI6tarF56EgBXqKRir6l
        XWV7prv4PE6+HbtlMtKM59PFHUg0EjY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-wlMoSROVOqekpdHLAsM0Iw-1; Sun, 23 Jan 2022 13:42:03 -0500
X-MC-Unique: wlMoSROVOqekpdHLAsM0Iw-1
Received: by mail-qk1-f197.google.com with SMTP id b13-20020a05620a270d00b0047ba5ddde8dso10612665qkp.2
        for <rcu@vger.kernel.org>; Sun, 23 Jan 2022 10:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY1U+lDZEduaUwZDUPPFY/UPA4Nbu9quyT81CXEx4PE=;
        b=uFhy7JYJVgnGor39iCZYrqMOTxce0OpDiJ6C90hkU8uBevtiWAJgtNo1qcEZFoxjDU
         8zGB6OGugPGIKazJcMKFJzi2wmA/hHg0ftWONfyYm5matY3PezGDKeeLgyqCMhEkUHJe
         69Yuyvfb4YZPRiVvehSEG9lHHWS86ZgxgRvxORU9lOFB+XZg5h+vdMOm0xV0is3PkyiJ
         ykYhUD6BVpsvPR6+XTYnzmctuyrpIJsu7llOblpULOhZwhilMVGjOBkU6JBzdBEpSdl3
         tui3gFJuxtwQXNTk/R8BMOlhpH0gttUl5Grmt6XZmpidVkymMjoUGjIxXtxg7S/gu0M3
         g9pQ==
X-Gm-Message-State: AOAM531wGoYS0QeMBydlYCcBrDS/yIbS9oIy35IAAX2oHNfoJYV1mbHI
        Y2bNYO+zBAFeVo+TDh7bVlqcfWk3PlAFQclzcHbNLkD5ADlyTRu90F0fZs/H9cBvE+olVGpgBfR
        r0DajjyQoT+eyqJ0gUCkJIDHovhXw
X-Received: by 2002:ac8:7fce:: with SMTP id b14mr9929568qtk.339.1642963323222;
        Sun, 23 Jan 2022 10:42:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgrnfftQev+/e1bfthcVXrqsS2NkZk7XaembGAyAtcFzDuZvrfItLL05jZqccEw/AGJEmBtbd/PLqLmStx2NU=
X-Received: by 2002:ac8:7fce:: with SMTP id b14mr9929550qtk.339.1642963322945;
 Sun, 23 Jan 2022 10:42:02 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org>
In-Reply-To: <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 23 Jan 2022 13:41:52 -0500
Message-ID: <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Randy,

On Sat, Jan 22, 2022 at 2:19 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 1/22/22 10:28, Alexander Aring wrote:
> > Hi,
> >
> > On Fri, Jan 21, 2022 at 9:45 PM kernel test robot <lkp@intel.com> wrote:
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   9b57f458985742bd1c585f4c7f36d04634ce1143
> >> commit: 658bd576f95ed597e519cdadf1c86ac87c17aea5 fs: dlm: move version conversion to compile time
> >> date:   3 months ago
> >> config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220122/202201221028.YKA8kSdm-lkp@intel.com/config)
> >> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >> reproduce:
> >>         # apt-get install sparse
> >>         # sparse version: v0.6.4-dirty
> >>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=658bd576f95ed597e519cdadf1c86ac87c17aea5
> >>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>         git fetch --no-tags linus master
> >>         git checkout 658bd576f95ed597e519cdadf1c86ac87c17aea5
> >>         # save the config file to linux build tree
> >>         mkdir build_dir
> >>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >
> > I have it on my list but it isn't easy to make sparse happy here...
> > this is the second time the robot reported this issue. Is there a way
> > to turn the robot off in that case?
> >
> > Maybe some human who reads that knows the answer?
>
> Hi Alex,
>
> In the source file, you can surround the "offending" line(s) with
>
> #ifndef __CHECKER__
>  ...
> #endif
>
> to prevent sparse from checking those lines.
> Sometimes there needs to be an "#else" branch also.
>
> 'git grep __CHECKER__' will show you quite a few other examples.
>

Thanks, I will try that to stop the false positives and endianness
warnings (temporarily).

I see also:

fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
'__srcu_struct_nodes_srcu' was not declared. Should it be static?

For a macro which contains the "static" keyword, it's
"DEFINE_STATIC_SRCU()". Either sparse should be teached to deal with
that or everybody should use "static DEFINE_SRCU()" instead of using
"DEFINE_STATIC_SRCU()".
I would like to see the second way because everybody can see "static"
is being used, that means maybe we should remove
"DEFINE_STATIC_SRCU()"? The alternative by doing nothing would be to
use "#ifndef __CHECKER__".

I cc here rcu@vger.kernel.org and linux-sparse@vger.kernel.org, maybe
this can be discussed?

- Alex

