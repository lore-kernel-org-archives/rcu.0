Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048AAC001B0
	for <rcu@archiver.kernel.org>; Mon, 24 Jul 2023 10:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjGXKMV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Jul 2023 06:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjGXKMA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Jul 2023 06:12:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517A51FDE
        for <rcu@vger.kernel.org>; Mon, 24 Jul 2023 03:04:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-682ae5d4184so1053072b3a.1
        for <rcu@vger.kernel.org>; Mon, 24 Jul 2023 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193068; x=1690797868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=am2eIoStEhYj6reS+R983QZxh6h3W0xYr71gNNToCQ8=;
        b=T/FIE+xxkvIPC2MsSEN5TVJQKoRZzt03Da8Cp144Q4I9BZ9fVrSLGGSsdukiFvahnW
         YCtlmq27BuBeVz7mwTsXT0daRDrPR72buiILNkdmJQ0QdENQLD5JczGwccUYen52hinM
         uqye8wE6f6yvOT3Rc73SDlLTBs+3vM/SfGS/UWBC9fDWoAdRWOL/MS8z68cmBD8yw0+N
         Wtzue8EoXLoqPMuYdKJw8/4wczm9T3o6sidOikSJkfa8hEEMc+SAuIx9U+sp8vSKqolt
         tQKYq5f8mAeTTgHBsmEnECykStYbT5XjJhFKGbNc30zz3cdOqA2C397uPZ/Wxmm9VW9t
         zKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193068; x=1690797868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am2eIoStEhYj6reS+R983QZxh6h3W0xYr71gNNToCQ8=;
        b=clSl7VlCpp0vYlYa1bomdmzcx9pFFK55Q6I38dncIdhIusn1mS45otrfnmYwf+m0A0
         hmkgaGc9XNvB0WhFt0xDm5//2TWf9pbJTp8Hp5p6uOZZkKXRPcJlzJpvAyjIK6Jk1w93
         G2b6ZtkH/XcO55kj9nU8I5y6lGmr90Z9GYJ/+pYDD2521wJSwn0LhWPZNNGmC8/JYml2
         ktZJtln/xa5be48j/ILCIjjKA37ijSs2VvMn15YH0rAeLbFObRx978tXKWlpJDRrVYfN
         RFEJHYSNixnCe0ImAGyyl8QMjFkj9UNGA0bcSq+N3M0s2XYor4Lad4HJJfvufeDO1BHr
         9fJg==
X-Gm-Message-State: ABy/qLaHAsyS8wwQrg1WeKUal1LrvcGR1fkZOaugny5V9pgBft7DU0RF
        +4+QEbjo7GoFTGFnoHXTSb8V4hgF36TAfCtzsko=
X-Google-Smtp-Source: APBJJlEtnCzvJ6I1rkWEELadVXHfZtUE/plpWIuGp/MFKpOvTS509ssN84iHDxA1POdeL3+D21rKQg==
X-Received: by 2002:a05:6a20:8e04:b0:137:3941:17b3 with SMTP id y4-20020a056a208e0400b00137394117b3mr14532126pzj.6.1690192601020;
        Mon, 24 Jul 2023 02:56:41 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b00682aac1e2b8sm7356787pfn.60.2023.07.24.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:56:40 -0700 (PDT)
Message-ID: <7b4eb3fa-1ebd-de07-1a16-9533b069a66e@bytedance.com>
Date:   Mon, 24 Jul 2023 17:56:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/47] binder: dynamically allocate the android-binder
 shrinker
Content-Language: en-US
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-6-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230724094354.90817-6-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


This patch depends on the patch: 
https://lore.kernel.org/lkml/20230625154937.64316-1-qi.zheng@linux.dev/

