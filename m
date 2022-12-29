Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F43C4332F
	for <rcu@archiver.kernel.org>; Thu, 29 Dec 2022 02:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiL2CjL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Dec 2022 21:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2CjK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Dec 2022 21:39:10 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F011819
        for <rcu@vger.kernel.org>; Wed, 28 Dec 2022 18:39:09 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j16so14128449qtv.4
        for <rcu@vger.kernel.org>; Wed, 28 Dec 2022 18:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+bI/PInPRC98qFA9k5hncItDaGS8mMQXxFI1nQJIp4=;
        b=X2ynwz0q67XMuFqwnARpn+k6f6pCVwzBmSoa/JoVIJz0mpklDIwy4BQoCDO7AXr7X5
         AVaodKL6gzNg9EWKnNAsdyX7N0JXDgaFH5lXFL91nNU4XwO/ULdXCvzYdk4LejlCrSli
         8anKcO2Wc1N0IYw2RNS8d2rZHCxtYlJemvVSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+bI/PInPRC98qFA9k5hncItDaGS8mMQXxFI1nQJIp4=;
        b=l+LYpIBEyOCO9WghaOj/N+mL7x6+dLwPwZaUU+Fo74MX9UWrWpEIph4qKC5iQIKFfK
         t0QRniWo9RehP9stCW75ZP/QKO3OzcU4wEel0A78aD5OVtSMdFw+qbGzzRKdoW9ItzUV
         OCiSFwY5kv+Qyh6QXFJNpw3SQRoRQNYJ7ilE2C0KQ1jD5bJqciSZiGbno2g4XSzES4N8
         3ysq1WXT524S25C9vHsVErUmRZSfZDZ3qUI3VTdy+CSa3zgNPJXwKtTJfGOIZ8+6RNPx
         /0uYs0I9jtka4ST18JydCKyWz2GVGX1w8/8dSdqwp9efhn1xlf95ELnbNRytEJu2G0ZK
         HD+w==
X-Gm-Message-State: AFqh2krhxHtm6t6kAxUbbKQOjufsuIs1qVu90RrVrC35oHlBc8G0Hyoh
        jamg6ml0vJcmEDbz4CegBbeO+g==
X-Google-Smtp-Source: AMrXdXtfXEyda9itEIFjgy+iQfO5XoZd/e24ccb0xfNWsvdAR0VCxpQwY2mQqByeq5+GiAmig8uJAA==
X-Received: by 2002:ac8:4998:0:b0:3a6:ee87:20e7 with SMTP id f24-20020ac84998000000b003a6ee8720e7mr32841312qtq.68.1672281548027;
        Wed, 28 Dec 2022 18:39:08 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bl33-20020a05620a1aa100b006f474e6a715sm12257335qkb.131.2022.12.28.18.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 18:39:06 -0800 (PST)
Date:   Thu, 29 Dec 2022 02:39:06 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
Subject: Please apply to v5.10 stable: 4d60b475f858 ("rcu: Prevent
 lockdep-RCU splats on lock acquisition/release")
Message-ID: <Y6z9ygSGmPNz5hfd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,
Please apply to v5.10 stable: 4d60b475f858 ("rcu: Prevent lockdep-RCU splats
on lock acquisition/release"). The patch made it in v5.11

Without it, I get the follow splat on TREE05 rcutorture testing:

[    1.253678] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.162-rc1+ #6
[    1.253678] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[    1.253678] Call Trace:
[    1.253678]
[    1.253678] =============================
[    1.253678] WARNING: suspicious RCU usage
[    1.253678] 5.10.162-rc1+ #6 Not tainted
[    1.253678] -----------------------------
[    1.253678] kernel/kprobes.c:300 RCU-list traversed in non-reader section!!

I tested with the patch and the warning is gone.

thanks,

 - Joel

