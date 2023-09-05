Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3B2CA0FFE
	for <rcu@archiver.kernel.org>; Tue,  5 Sep 2023 16:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbjIEQ0y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354321AbjIEKmB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Sep 2023 06:42:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0826199;
        Tue,  5 Sep 2023 03:41:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so36027991fa.2;
        Tue, 05 Sep 2023 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693910516; x=1694515316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VB/9cNvOGhv5c3NUZyMsbBoZmZ2eYSe7kvAqrZUWzlk=;
        b=ijrAr59+35locDJkR2k8hCb341F5DBM9RHkhvRD8K94i5k3ScAxOYmLTDle55AL3da
         w7srFqTtpuy4Ly3zqmsELippP7srk7QxzcdvDJFglOZJ6Mz2dXq3v5eItSEm2REyr0d1
         zXavYhp57uH7hjnm0tPiNaMx1FHKv9wryVtu4SqBSu2Q+lckDfOWzV5t/1qT1nY/0A7+
         62wzZa+ad/p0DjInqXFJY9eB8QYzAFhZE2n4MJ26ZS3rCY3rEsegWD8izKoUhoLcX/yi
         b8hzolILxOI4YVb1vorN0aCPwJvql6XC445V8IESFOhnRmGslYoO9zNubQbqK13x7kX0
         h6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693910516; x=1694515316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB/9cNvOGhv5c3NUZyMsbBoZmZ2eYSe7kvAqrZUWzlk=;
        b=Vz3G8lCTTM4nryqPUl87phE2dwBWM/XroCWz6k0BETEftd31FNOl0BinER9E4thoBW
         /glhsGxGrA/uyf+CORggPmGUXLxwpzHXdbgpNesNA3HpBnR9fsQSKuvHc+YB5eXvH+Z8
         Yzfp0H0Hwdzy9rmZRgPUlbaTjVtwZpIHv3ihHEgjvE206ITTw/Cd9VdSHXjQS+c+Se5X
         HydTUh3YmLeyu/dXALn4SMNFsk9I9zWBmrCQakxjmyHOk6sVrshju7Ak2VSpJsqMlNb5
         fqeFR6xVKyRdnu7m6EHwdUYaiJjZ3IfvsR3sdfxVMAbOm+wkEvM4MRaitVKG8A0U9Xfk
         p4lA==
X-Gm-Message-State: AOJu0YxzVeRDgGJdCSNaCDAi0bi3e8OH16RcXQlQUdM1CEagKuPSw4wm
        L+ofm8nZ4Sxf2mnpaZc+0Ps=
X-Google-Smtp-Source: AGHT+IE/snxwuH+65B33xT1AlIo4pHbfnCw2nQotBmme5dmGs1e+Oekn2HzbtEwM8Vq5u0bFL59skw==
X-Received: by 2002:a2e:984f:0:b0:2bc:ffec:742 with SMTP id e15-20020a2e984f000000b002bcffec0742mr8317510ljj.49.1693910515888;
        Tue, 05 Sep 2023 03:41:55 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id w7-20020a2e9bc7000000b002b9ef00b10csm2850226ljj.2.2023.09.05.03.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:41:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 5 Sep 2023 12:41:53 +0200
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZPcF8YLo9tJqYX8Y@pc636>
References: <bb603efb-654f-4686-bad9-0bb5379745c0@paulmck-laptop>
 <CA+FbhJPtmFG2vKNXWr67Tuh-4HUi8n81PmKxwftv9iK1a3On-A@mail.gmail.com>
 <ZPW+KJCIAvFzZHl8@pc636>
 <CA+FbhJPNZ-E3e7WBH_jAvi3Rn-2gV4TVk9S9qmheXkqXw+Sakg@mail.gmail.com>
 <ZPXyUTteVxXtqiEo@pc636>
 <CA+FbhJMr6LzmOpVNkYyiSERAsNEqqvQwQ7SwJK=CmwvV9d2Z-A@mail.gmail.com>
 <ZPYLmm3ih7u95l1a@pc636>
 <ZPYsY2HEjySkq/NR@pc636>
 <CA+FbhJPNK=4s8J5OqOBaDC8EDNQzevQMQ+fwZnfxG92ReabQOA@mail.gmail.com>
 <CA+FbhJMEqLycroz=J6VvC=4OBaJSwz8K+K6Zgki80M-5YdYp6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FbhJMEqLycroz=J6VvC=4OBaJSwz8K+K6Zgki80M-5YdYp6A@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
> For a comparison, I've attached a journalctl log for my custom 6.4.14 Kernel.
> 
Thank you!

--
Uladzislau Rezki
