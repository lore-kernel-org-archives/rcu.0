Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0953C433EF
	for <rcu@archiver.kernel.org>; Fri, 27 May 2022 08:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiE0Iap (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 May 2022 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiE0Iam (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 May 2022 04:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FDCFF6888
        for <rcu@vger.kernel.org>; Fri, 27 May 2022 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653640241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TR2Yi3TabZ8KESWGazD0t1fMBCkgs8Tx+KayBLPN0TE=;
        b=eD+eJKIzr9mBs7B8rTMQeOZz6+sZo3gkBwF0DEc+D0dOEYn5eTbUMPjtG71QGlJaU6pBAc
        WYFkC+hqFMreDKTkyoWpBKby+b/aAs224vhHY+MKfAa67B2B/rhoqCzs2dMVSXzuGKyL4j
        RrTxhsc65JH2bZowPS0uUglCjf4fb7w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-aD_8LJlZPla0jH8NEoJ68A-1; Fri, 27 May 2022 04:30:31 -0400
X-MC-Unique: aD_8LJlZPla0jH8NEoJ68A-1
Received: by mail-qv1-f70.google.com with SMTP id de12-20020ad4584c000000b0046266e975ddso2933870qvb.8
        for <rcu@vger.kernel.org>; Fri, 27 May 2022 01:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TR2Yi3TabZ8KESWGazD0t1fMBCkgs8Tx+KayBLPN0TE=;
        b=zVqiCvU1F2q6wFFg40aZZCLz58ZjKAPGnDUoWyUK0Hmc/6pxW2QRcJVbIw4Vzk60Pl
         9/S+0xvT0EKxOP4LLJ1oVbbXa0WCR1Js1PEM6Nox87rTl+uFghgJ7Gvl4n3AwopqbZRI
         HET7p4od/Sl0s3+00jdPX4CjY8LcWqKGGtC20W/xIwMaATmAik/lvKzlqiutS6w3hn52
         zyUS57flVmkO8yzxcM4Z5hyVi8KY8/mAdbkDvY20wA10JVbR6omWGwIFQ/LaWIWXIUh4
         0rGtISLQhsS7T6cNxghhit9PeGzMHDROlNDs61PIobmO4VhIr6BZt4nr1pOPkTycRPKS
         fMNw==
X-Gm-Message-State: AOAM5321MamxTUaly+2s4Ke0Rn3qIcwcYAt6sMJXNwAk7KPtlbngyQXI
        aR19xXWzEkSKyJcgCZJKZjO0+Gwg5LBYveCbw/dqRFO/fEjZgbYE1QOAHycXIT9Rk9jeD/Th4d3
        uO5GVRvPJ1nSp
X-Received: by 2002:a05:622a:1456:b0:2f9:4569:1338 with SMTP id v22-20020a05622a145600b002f945691338mr13565883qtx.385.1653640231177;
        Fri, 27 May 2022 01:30:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya/0SapQcwBr/iLbWrDlhntpdfbhznqsLbuxqJJCuXCslAXkh5RvQSrs/hMKYnkRqFHAY6eA==
X-Received: by 2002:a05:622a:1456:b0:2f9:4569:1338 with SMTP id v22-20020a05622a145600b002f945691338mr13565871qtx.385.1653640230917;
        Fri, 27 May 2022 01:30:30 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id l21-20020a37a215000000b006a377a015d4sm2483596qke.39.2022.05.27.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:30:30 -0700 (PDT)
Date:   Fri, 27 May 2022 10:30:18 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpAdSW8JXVPOoNJl@slm.duckdns.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 26/05/22 14:37, Tejun Heo wrote:
> On Thu, May 26, 2022 at 08:28:43PM -0400, Waiman Long wrote:
> > I am thinking along the line that it will not be hierarchical. However,
> > cpuset can be useful if we want to have multiple isolated partitions
> > underneath the top cpuset with different isolation attributes, but no more
> > sub-isolated partition with sub-attributes underneath them. IOW, we can only
> > set them at the first level under top_cpuset. Will that be useful?
> 
> At that point, I'd just prefer to have it under /proc or /sys.

FWIW, I was under the impression that this would nicely fit along the
side of other feaures towards implenting dynamic isolation of CPUs (say
https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/
for example). Wouldn't be awkward to have to poke different places to
achieve isolation at runtime?

Also, I wonder if a proc/sys interface might be problematic for certain
middleware that is substantially based on using cgroups. I'll try to ask
around. :)

Best,
Juri

