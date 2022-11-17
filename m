Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE980C433FE
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 03:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKQDo4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 22:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiKQDoz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 22:44:55 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B532D1CF
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 19:44:54 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-36cbcda2157so6970367b3.11
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 19:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mX/nVVLR77rl9DUJUGIPDy2hSVN2IuYJAyXn0XHxv7c=;
        b=cP7nrbODehEq41oxats2cCXRpCH3pgtt27PbJxs7RbS06z34/NEe4qwUp4RITt1nt1
         D/+HUWdgQAzDfbnGNQt0SNs5qqtb7DwaTu4c/0wDA9k1Mr5ov9IIVAqZj/kXjmCZFWoR
         /9RKa/XwGL88By0mdsQ7RUST7DpM3xlbnGbjQiVnvUZVz+ypi1ljTwI7tQMHNPfptF5a
         0bOC1eb3DC4AqpsSdu1TBTTXy1odyyGyw99u5V9ow9IYRYZz+X66gW39g8t0wfcvT3mw
         mA/jDa11l/7qpNohYGDSOga5+DA8QS9s5UQ0Nc5VfcaEkybbSDsi01PW+1wLp2LblJ52
         Mh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mX/nVVLR77rl9DUJUGIPDy2hSVN2IuYJAyXn0XHxv7c=;
        b=Qf3EmTUXSIroDS+wLwF69JXO6KktahWyQxvijT4nNM+l14XLhlXkrfHF3mHa3nCoBl
         imhuVwt/DfV7M4bMwH/BJ7SQeyjTZY/z85AwOFnveyOzVpYjh/h2EszP0u30bVcI4ty5
         MMQ4zfdZsyGVg43s8Gwk62F8msGbnXH1HJwi/J2r5vAXqeI1DfXjbjeGxGjHhYZWVnvi
         0AXG5CtDhDQCjiTdnv2mO7auklsd4KwADXgPPx5hw1J0hQLtp2J+ChxFX58DHHgF26Dq
         tyl9K/vP2ESpvCV59eVBjRzeWirVNv3NcbqLgoh07dBhStN0KBM4xq7RXeWJDNu+942o
         W5SA==
X-Gm-Message-State: ANoB5pmlf/ksM66amM2rhaMaLxn32Flf5oHA7OwVknAc8Yeu6T+ByVt6
        WAlhg+n0qIMd7369RB0jskILzqufjbyKphuoEtjQow==
X-Google-Smtp-Source: AA0mqf4ND4dr0qcwB0X64sQlUuAXu8iyuw4JOxhuWSakyAMfQKzY2rMLgSiX+xKDzhLZGfkZfM4rN3c8+1+X8QDR9bU=
X-Received: by 2002:a0d:c103:0:b0:370:7a9a:564 with SMTP id
 c3-20020a0dc103000000b003707a9a0564mr427025ywd.278.1668656693295; Wed, 16 Nov
 2022 19:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20221117031551.1142289-1-joel@joelfernandes.org> <20221117031551.1142289-3-joel@joelfernandes.org>
In-Reply-To: <20221117031551.1142289-3-joel@joelfernandes.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 16 Nov 2022 19:44:41 -0800
Message-ID: <CANn89i+gKVdveEtR9DX15Xr7E9Nn2my6SEEbXTMmxbqtezm2vg@mail.gmail.com>
Subject: Re: [PATCH rcu/dev 3/3] net: Use call_rcu_flush() for dst_destroy_rcu
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 16, 2022 at 7:16 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> In a networking test on ChromeOS, we find that using the new CONFIG_RCU_LAZY
> causes a networking test to fail in the teardown phase.
>
> The failure happens during: ip netns del <name>

And ? What happens then next ?

>
> Using ftrace, I found the callbacks it was queuing which this series fixes. Use
> call_rcu_flush() to revert to the old behavior. With that, the test passes.

What is this test about ? What barrier was used to make it not flaky ?

Was it depending on some undocumented RCU behavior ?

Maybe adding a sysctl to force the flush would be better for functional tests ?

I would rather change the test(s), than adding call_rcu_flush(),
adding merge conflicts to future backports.
