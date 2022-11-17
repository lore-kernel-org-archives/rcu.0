Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F1C43217
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 15:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiKQP6a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Nov 2022 10:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbiKQP62 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Nov 2022 10:58:28 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2652D4
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 07:58:24 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id x21so1488775qkj.0
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvFYBEk1i0yKc8+3u2UZQhwgiXMpi4zV8qerEA3nQas=;
        b=S5pF0R6jtqRxB1PRynwjuQVFoIfcIfq067APWyQr0H7l1Ikno52hTU432IqQlGx/+P
         8cksXWIPDkHHplO5LD6YabMTHyMA/Q4j6R1o0e0+/JYgzprdS/7P8XYCZRP8jh7X7ygU
         AqhRqC6vcCcYcHSdDTD/LtZgI/OOwY330GQOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvFYBEk1i0yKc8+3u2UZQhwgiXMpi4zV8qerEA3nQas=;
        b=aDBJv9g7pmEnBqA96WSlEsMzERS4scjl+onYsAC16655lblU8eeklGkIxM8+bG7XLb
         AccdVMXaOfBq+oCkW7149dOzy3+iIeOousiA6J/ALIDDkRAYNLfv0Wa1KncaeiG5KDdv
         MqCdax0zWujjWwm0Q61JqrwonKmV0LnoI+epmbGyvS6OhFoo3MHDXmZPzPa2KVVkAgGL
         WfPkFGx01+iTdXVYSGf3t23rNLQXw421w0iJlcq1rPV+XBD2boVWMnW9amntV8PrrzHr
         mv8LdtJqfWvsdM/ZvFtRnZ/80qwZ9N3YU0s950UYfQEdzORAZXt15XP0ErbQj/h6ggCI
         zbqA==
X-Gm-Message-State: ANoB5pk5EzBGwYVgws6CFLbUz1Vhv1aT1X4ZCAYg+sA2DxmEWkcPqHpu
        9oc05ssrEDSxbApLPraTVaxZ+Q==
X-Google-Smtp-Source: AA0mqf5Hd2qofZbXHQJNAd80sMN47/3HrT/2DpFAwKf4m28S4pEddTMzSHTFk+t9dM7MkjbivdcjNQ==
X-Received: by 2002:a37:94c6:0:b0:6fa:2ff9:e9ca with SMTP id w189-20020a3794c6000000b006fa2ff9e9camr2284267qkd.29.1668700703805;
        Thu, 17 Nov 2022 07:58:23 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006fb7c42e73asm688995qkb.21.2022.11.17.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:58:23 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:58:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com,
        jiejiang@google.com
Subject: Re: [PATCH rcu/dev 3/3] net: Use call_rcu_flush() for dst_destroy_rcu
Message-ID: <Y3ZaH4C4omQs1OR4@google.com>
References: <20221117031551.1142289-1-joel@joelfernandes.org>
 <20221117031551.1142289-3-joel@joelfernandes.org>
 <CANn89i+gKVdveEtR9DX15Xr7E9Nn2my6SEEbXTMmxbqtezm2vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+gKVdveEtR9DX15Xr7E9Nn2my6SEEbXTMmxbqtezm2vg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Eric,

On Wed, Nov 16, 2022 at 07:44:41PM -0800, Eric Dumazet wrote:
> On Wed, Nov 16, 2022 at 7:16 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > In a networking test on ChromeOS, we find that using the new CONFIG_RCU_LAZY
> > causes a networking test to fail in the teardown phase.
> >
> > The failure happens during: ip netns del <name>
> 
> And ? What happens then next ?

The test is doing the 'ip netns del <name>' and then polling for the
disappearance of a network interface name for upto 5 seconds. I believe it is
using netlink to get a table of interfaces. That polling is timing out.

Here is some more details from the test's owner (copy pasting from another
bug report):
In the cleanup, we remove the netns, and thus will cause the veth pair being
removed automatically, so we use a poll to check that if the veth in the root
netns still exists to know whether the cleanup is done.

Here is a public link to the code that is failing (its in golang):
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/src/chromiumos/tast/local/network/virtualnet/env/env.go;drc=6c2841d6cc3eadd23e07912ec331943ee33d7de8;l=161

Here is a public link to the line of code in the actual test leading up to the above
path (this is the test that is run:
network.RoutingFallthrough.ipv4_only_primary) :
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/src/chromiumos/tast/local/bundles/cros/network/routing_fallthrough.go;drc=8fbf2c53960bc8917a6a01fda5405cad7c17201e;l=52

> > Using ftrace, I found the callbacks it was queuing which this series fixes. Use
> > call_rcu_flush() to revert to the old behavior. With that, the test passes.
> 
> What is this test about ? What barrier was used to make it not flaky ?

I provided the links above, let me know if you have any questions.

> Was it depending on some undocumented RCU behavior ?

This is a new RCU feature posted here for significant power-savings on
battery-powered devices:
https://lore.kernel.org/rcu/20221017140726.GG5600@paulmck-ThinkPad-P17-Gen-1/T/#m7a54809b8903b41538850194d67eb34f203c752a

There is also an LPC presentation about the same, I can dig the link if you
are interested.

> Maybe adding a sysctl to force the flush would be better for functional tests ?
> 
> I would rather change the test(s), than adding call_rcu_flush(),
> adding merge conflicts to future backports.

I am not too sure about that, I think a user might expect the network
interface to disappear from the networking tables quickly enough without
dealing with barriers or kernel iternals. However, I added the authors of the
test to this email in the hopes he can provide is point of views as well.

The general approach we are taking with this sort of thing is to use
call_rcu_flush() which is basically the same as call_rcu() for systems with
CALL_RCU_LAZY=n. You can see some examples of that in the patch series link
above. Just to note, CALL_RCU_LAZY depends on CONFIG_RCU_NOCB_CPU so its only
Android and ChromeOS that are using it. I am adding Jie to share any input,
he is from the networking team and knows this test well.

thanks,

 - Joel

