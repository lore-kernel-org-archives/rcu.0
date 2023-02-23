Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA34C61DA4
	for <rcu@archiver.kernel.org>; Thu, 23 Feb 2023 14:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjBWO5S (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjBWO5R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 09:57:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CD1FC4
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 06:57:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y2so8990280pjg.3
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 06:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOrs/sECY5IdqQ6ALIEC6kcZ7Nm3MI4GfsmPNZdf/uQ=;
        b=p086KusUNB7wVWdTpHZBz3Z2mJ4dEa6VXJbxBJ9u+f1V8GDzUDpAF3RKghNujM0XsJ
         gNp8k/HjZcpyyY/vvHaeRLKLIFiInvk+73XucztNg9kSb7FzjAv6H8TPVovPjIkvB9nc
         xNJwNGckXC88lEHEC0DpeQCauqXr/bfTcJKowKMip2ZXjzuB3VWXyGFhfMk7KIiOp+ih
         BAEOTcpQiXjez1J9wo0egYapTnSBCol6o3mIbZx/wqljxD7Ig8Xj+sYP97HuPH7E4XWh
         J79sA9x1Gj0CuQX+YcFV4ls01LguabOucKJRZqYOsOmU8akAl8DYpe/OpGsqSf+H9vp7
         1CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOrs/sECY5IdqQ6ALIEC6kcZ7Nm3MI4GfsmPNZdf/uQ=;
        b=wSLvmupl6xrEOSZX7Q4raWsaaLeZ4mXmxS9B+19mxeHL+1t6SJjLUU8a3h45HYkocv
         U9wgqGSOmssykDnW9GUyYB1meaSZvSfoy+GHGQt62FL2dDXjINNv+QWHFXfAJk+PsfuY
         bIwY65+Q5kWGgcPf5HJgUCrJ2Q4XuQw6a6Ee6dUp+b/X1QNjwDQeYUfzD6LPVhJqLCir
         zCqs2KbQGleJ60IBUt5+mm0jdxTzl+a+vImCWXGurW7v+dJY6Fch4rbCz+OoiI+JriOk
         XRwCLvyeCNzOMEoHVfUpFxzryLowwcyHsz+JFU1dYQFy+8rzO4sEfYKDivLp808jKTBo
         q9HA==
X-Gm-Message-State: AO0yUKW/fksJOQ0SIqaTc4OezjxLJpjovGXabXCwoDTElopUkxuIRDVA
        9lp/uXbPg3KZITsyBOVoj7Jakw==
X-Google-Smtp-Source: AK7set/b4XOqO4wdgHANlDTSss/k5KwrHGatZe6vonxTfRaL/w5QGX2cVhw30nLEQ/y7/7WZNNrEXg==
X-Received: by 2002:a17:902:e84b:b0:19a:723a:8405 with SMTP id t11-20020a170902e84b00b0019a723a8405mr11540573plg.6.1677164235825;
        Thu, 23 Feb 2023 06:57:15 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001888cadf8f6sm3330012plh.49.2023.02.23.06.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:57:15 -0800 (PST)
Message-ID: <84fd00b0-aa87-e4b7-e0a4-d57b720216c0@kernel.dk>
Date:   Thu, 23 Feb 2023 07:57:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
References: <20230201150815.409582-1-urezki@gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2/1/23 8:08 AM, Uladzislau Rezki (Sony) wrote:
> This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
> it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
> 
> 1.
> The problem is that, recently we have run into a precedent when
> a user intended to give a second argument to kfree_rcu() API but
> forgot to do it in a code so a call became as a single argument
> of kfree_rcu() API.
> 
> 2.
> Such mistyping can lead to hidden bags where sleeping is forbidden.
> 
> 3.
> _mightsleep() prefix gives much more information for which contexts
> it can be used for.

This patchset seems weird to me. We have a LOT of calls that might
sleep, yet we don't suffix them all with _mightsleep(). Why is this
any different? Why isn't this just a might_sleep() call in the
actual helper, which will suffice for checkers and catch it at
runtime as well.

-- 
Jens Axboe


