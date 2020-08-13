Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72E0C433E3
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BB320774
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 17:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S54VwkqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMRWX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgHMRWW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 13:22:22 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ABAC061757
        for <rcu@vger.kernel.org>; Thu, 13 Aug 2020 10:22:22 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id k63so1374458oob.1
        for <rcu@vger.kernel.org>; Thu, 13 Aug 2020 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=C4dUS/W3AY+La0y5eMDLrhZCz6pWvP5bo1JzAo1BDEs=;
        b=S54VwkqFFwVFCsaZc7krxnwXIGcSIS4onPffWCkXcY34QyJeIxyjyIOcOYGf07IDLR
         pQzMt8SR9BHvcCUdHjjDrRKb9AgQ4iBocoW9wYH0n72HIvp+9HK7/m6P4sHE3oKwjKNd
         pkslF4UsAisLbzpwFJv2J0qd6IfvN+pUBRkDA7Mj2YQN95VID9N5FLfgWZG0HBXhfLxm
         HinR2zljBbwYnqCjmmjJDwj1ro4N1NwNKxOBLOjoF3KOmcCbHXo871BVbmZqeseANgeL
         QXfcOHlSPRDT0rQUmBQv2ZCpOnCFVHwzIy9hljIRh01d1IJlANjCwG/hqH8lh0nZg1nK
         eEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=C4dUS/W3AY+La0y5eMDLrhZCz6pWvP5bo1JzAo1BDEs=;
        b=kp8gwPHwE+p0uVybT8UVFN8LnpNFzb8JcunGFZwDjZkHBvEIwso8mZnd1bpMREeZ8D
         /wJMzvXu7d8MIHVe9FCbeOqrtEZBX56UWPy6rQcMV5Y4LdY0hqiLM1e+/BR+EVsOGiSf
         FyEp28ACXWKYnSignSbU2jMFzDrvsFATemuH77hT58+tzuM5fuQ6NzGHn8W4QNhq5AlY
         ZQZmLhIDZbQp1ibN5HlHHWg7p27z61b/YtR7BLRF9tmUnYgYT17YQ4xSmRS44ZKD1QRG
         2R3Xio/0unLlIjNS0KRHidknK0Nc604tnsrpOZpBo4/SpTutiQZppEL2M9gyWOBuowcw
         K9mQ==
X-Gm-Message-State: AOAM53323bp0J6Y0kvmRe9dibzBnYZLm+VQ8wLHczWImbqYkIAge+ZHO
        HAB7g2BYNa99+5y/FcGuTO2nA2aeBxrYtCwWyuiMjkuOvMI=
X-Google-Smtp-Source: ABdhPJzRnUawJd+G31myahAudi6LY+4Uuef7/YX8ch0q3CZOWNI24zeo9MVctIjS1oBQsVy0yuYmnpJ1DZJZeVAwBL8=
X-Received: by 2002:a4a:3b0f:: with SMTP id s15mr5503185oos.71.1597339339950;
 Thu, 13 Aug 2020 10:22:19 -0700 (PDT)
MIME-Version: 1.0
From:   Chao Zhou <chaozhou1018@gmail.com>
Date:   Thu, 13 Aug 2020 10:22:09 -0700
Message-ID: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
Subject: Allow multiple GP misses before Panic
To:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

Some RCU stalls are transient and a system is fully capable to recover
after that, but we do want Panic after certain amount of GP misses.

Current module parameter rcu_cpu_stall_panic only turn on/off Panic,
and 1 GP miss will trigger Panic when it is enabled.

Plan to add a module parameter for users to fine-tune how many GP
misses are allowed before Panic.

To save our precious time, a diff has been tested on our systems and
it works and solves our problem in transient RCU stall events.

Your insights and guidance is highly appreciated.

Thanks!

Chao
