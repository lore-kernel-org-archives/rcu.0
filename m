Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575BEC7618D
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 23:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCOXTX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 19:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjCOXTW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 19:19:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE198EB6
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 16:19:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s17so11761444pgv.4
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 16:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678922360; x=1681514360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFMCxULO8QKbro8N2aWnp3bJ+wkQuvOtMXFpr7qNWdc=;
        b=mydXcGTKsWbPvI2OhYKhwXF5JJk2ew/KcYd+p+uHl+N5QMnusBKd3mARgeAdyXaVgp
         bF1G2XcZOD6vLmlJFY/xy+9ygQBBCnxVQhBxDXOo6CoQT+PWfhCZgGxaxrMpQjbknb9n
         jNK04wI90GwP5qSOxwOyo7qZxCsZaz18BwkDhY2jRiHJyNPZEHGfcA9irA4TQtnn2d9j
         QtXR88OsuMGxXUp/Lz8Zt9hnN2iPzNPwN1g0fOXwomJgBU8fgv45jvYGOaUTJOeSMI5U
         IPsDaZEnT4EUvqgLxfM73HhipQX/6IweGbTFOZXNQCq5HD/fjoCnbIH4154d2k5NHjkI
         Yydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678922360; x=1681514360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFMCxULO8QKbro8N2aWnp3bJ+wkQuvOtMXFpr7qNWdc=;
        b=ZZAzTXD6jYBX2ZVp5oyQCDyvqsOvGV8NGETdAjIWLPh/vcuP3vXbaaY4oTQwqS/f/N
         L1ls+CNMgy4VBV6lRIdGqp4RUOiRIfHGeDWoSua4hAe6qw9ihoAol2g/KZNNuVbZe50G
         vj2zL7V+AjEXTO8fN85ASw70pfHyRZ9Ip12l+3X8nRMayZxZBTiN/uRqHybYW6T0cC11
         fQW7LXga8OEa2x7KvXKudSIgefS70LTyiouNmroG+YCjXnsltoMHJya37guyPxTszC3g
         ROmayCiBucMT86Pd9qxaLBYMN/luR4ODAt9wRp8dhZN995cdswwyvucBJ7qjRtV+ww/L
         C+Fw==
X-Gm-Message-State: AO0yUKXjkVNmvPR9V2xFJpyLdCwwLRhPrcMCQrbZT81NJIkpgOKSes5S
        mYK0elzGtwHFP6JFTRzm/g1Oiw==
X-Google-Smtp-Source: AK7set+Hma8u9TEs915EVIsLiAy+0Y4mWgPfUSUOJeHLd7V2gCzgFZGfk7KTj91OKQtGFxZt7CuRMw==
X-Received: by 2002:a05:6a00:3186:b0:5a9:cebd:7b79 with SMTP id bj6-20020a056a00318600b005a9cebd7b79mr1261763pfb.0.1678922360361;
        Wed, 15 Mar 2023 16:19:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z13-20020aa785cd000000b005a852875590sm4059408pfn.113.2023.03.15.16.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 16:19:19 -0700 (PDT)
Message-ID: <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk>
Date:   Wed, 15 Mar 2023 17:19:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com> <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230315183648.5164af0f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 3/15/23 4:36 PM, Steven Rostedt wrote:
> On Thu, 9 Mar 2023 14:45:21 +0100
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
>>> The kvfree_rcu()'s single argument name is deprecated therefore
>>> rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
>>> underline that it is for sleepable contexts.
>>>
>>> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>  
>> Could you please add you reviwed-by or Acked-by tags so we can bring
>> our series with renaming for the next merge window?
> 
> I don't know. Perhaps we should just apply this patch and not worry about
> sleeping and whatnot.

That's a cop out, just removing the one case you care about. Fact is
the naming is awful, and the 1/2 argument thing is making it worse.
If a big change is warranted, why not do it right and ACTUALLY
get it right?

-- 
Jens Axboe


