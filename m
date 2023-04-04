Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55424C761A6
	for <rcu@archiver.kernel.org>; Tue,  4 Apr 2023 17:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjDDRCI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjDDRCG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Apr 2023 13:02:06 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06889DF
        for <rcu@vger.kernel.org>; Tue,  4 Apr 2023 10:02:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n125so39465388ybg.7
        for <rcu@vger.kernel.org>; Tue, 04 Apr 2023 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680627721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EZxuHLFtNW6DOyg0Up2V+fzvewo/xPE26/VxJVS43KM=;
        b=pgXOVRk9JdN65LKkNabkbTgzcBobSkNY05vjQSWL2ErDYSW2u6yUUWyhVR4+r2GJYt
         Rf4AXFDHOXCQSthx35gkOeGIBo1tbYTlBSlk4MAF6EFssBpLhT+65wJ3UG2dgAv8tT2l
         Uc6L3Z3flUUKu6E2pXFBh/K2Xsr7UnuH1oXJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZxuHLFtNW6DOyg0Up2V+fzvewo/xPE26/VxJVS43KM=;
        b=eq0gWaY5fLUlHmM0rz4dDdZBFwqxEdQmVfhDEH9fsL/VrrVxK+e81lmxojSY1wR+gr
         9gLNax68oDxTmz1N5cJzborwiB1Hkao0mzL8ui5/2bfImOQSoienLtNqNfDLOmEwlzgl
         xs3bEEcF6oIalG3TiPK7m0+irJw6u6AxyqlGeQo8Ba2OUZCNc2foXsgNcXNRKJ9Gk0mf
         bRA9ct9wKggtf3hDKTku32rxY9vn6F7w5+r1TobOYVQwtJB/rFHaCAZawxiv82m4WXts
         Ta4/x0Y8M3fgecx8VctOKVwwTW5x2LFbefR/gTfLUArK/syX3Pu88/ay1E0KLthzh56R
         hTJQ==
X-Gm-Message-State: AAQBX9c1y6mAV2JMRlgh+kFbPSeBaSiwxcJEH9gDOUcsKVGxAqzrlwQJ
        u7RYsuJ4mmwPva4bh4+QwlvC3Pqzb18SWHupl9KIA8o0xbQ3vhf0FS0=
X-Google-Smtp-Source: AKy350Z7TmeWoGKs4uFwycO48nTq5+V4hfheLwSgeAH2M5abZ8O02ny5Sy+MxzKC+4uu8XORDbRs7SbiinLtq9cYgD0=
X-Received: by 2002:a25:d984:0:b0:b69:fab9:de39 with SMTP id
 q126-20020a25d984000000b00b69fab9de39mr2006909ybg.2.1680627721079; Tue, 04
 Apr 2023 10:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230404135741.GB471948@google.com> <f2ae6531-1443-47e0-8897-0a47ca61ffec@paulmck-laptop>
In-Reply-To: <f2ae6531-1443-47e0-8897-0a47ca61ffec@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 4 Apr 2023 13:01:50 -0400
Message-ID: <CAEXW_YSSSFrRpb8bM0=ebBkJHQdFGuEWRAUqGesdonk9bNohTg@mail.gmail.com>
Subject: Re: [PATCH rcu 0/20] Further shrink srcu_struct to promote cache locality
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[..]
> > The "improperly set" thingies are perhaps Kconfig on ARM64 setting some KVM
> > options slightly differently. I have seen that before as well on this board.
>
> Agreed, and one of the things on the long list is to allow arch-specific
> settings for those options.
>
> The CONFIG_SMP warnings are interesting, though.  Does arm64 disallow
> !SMP builds?  ;-)

Yes, it looks like it. As per arch/arm64/Kconfig, CONFIG_SMP is always
'y' and cannot be set.

config SMP
        def_bool y

Thanks.
