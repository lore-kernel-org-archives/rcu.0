Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C47ECAAA1
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 05:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiIOF6m (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Sep 2022 01:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIOF6l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Sep 2022 01:58:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232609019F
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 22:58:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so7078303pjo.2
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MtOWEGkrWE/F2NsDZP97RsxQVhjrjiyNsLXZQ+pqcJs=;
        b=GzUXlsDfmUcBaQjIS0Ma6ZrsKavkmR/gBiaE0r6drYMgvqmL6U+xsj6C8yPcTNuqjq
         PrGmD2wlbr4FxXpCWIhxb+z5pjHSu6uY4GL02GodV5I3RXjwaEMWgvogJ8rOCfmxGCLn
         EcZeCfLrloul9XVhheNe7Q4vvQayEzHnIrEZEk96xVG0ZecKtg5nvMqWogn2gq0Q74Vu
         x1rzd4FJ6AB5QbhWzkgKTbDmy3QsSctVVFqvihvxo8avKRtvCnMwbYKX1yKkZRHbOC7j
         URfd2bD0Pa9m+EhC/WfygtEKyX5ge4OmDWO1hjIRILkf+wsCeJTsR6736YLtkPLj8KJJ
         ihWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MtOWEGkrWE/F2NsDZP97RsxQVhjrjiyNsLXZQ+pqcJs=;
        b=zjpK56Cj9LiCGO2s6sHIJx19E+9D5qtq+3uPmK8vo1IicOVJA2nfAqDcb/SG4+6AKW
         0MNBY8mUxXSrNWQYaN8EoTNoyTU/ui/fe/nrAS8Nr+vAmJsSLinxh54Q63ciLUAlYYZn
         H3Op31/NtFflYUnmloCNgQxwKnTu9rleznFNcgy6J2VRTy3XUeRYkU+UGO8FkiTMFKPx
         GgZX53E9rMQgD3rtjTRNjYRN6VIvOFPPjO7PLdsw8EA9Jdxrqvgak/80hsl1xKjwVMYR
         nSqLl/0qiiL1fNmPEYeqbmzNkhEeApsvE0HOMMK1ouGtHCrw+4ONs2d/+3Mp6+FTiCBt
         slJw==
X-Gm-Message-State: ACrzQf1sfXTQQOTf9LgUyJZRN//iTLnTjzDqyIjOQLg9fSwdk+22oLGh
        D1iAPa8Z9Z8BeO71oxhz0kdOfR8PbQ==
X-Google-Smtp-Source: AMsMyM6LeL2taj5DDQmzcLf8+h+VU58pazCQSCZLvbn6ECaivEJ9f7t4FS6BonU7rNqyUKVji8wgzw==
X-Received: by 2002:a17:902:f807:b0:178:516c:128f with SMTP id ix7-20020a170902f80700b00178516c128fmr2673829plb.77.1663221520147;
        Wed, 14 Sep 2022 22:58:40 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001768452d4d7sm11983386plg.14.2022.09.14.22.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 22:58:39 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCHv2 0/3] rcu: Enhance the capability to cope with concurrent cpu offlining/onlining
Date:   Thu, 15 Sep 2022 13:58:22 +0800
Message-Id: <20220915055825.21525-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[1/3], It was V1's [3/3]
[2/3], reimplement V1's [1/3], and fix the issue in
       rcutree_offline_cpu() instead of rcutree_dead_cpu()
[3/3], handling TICK_DEP_BIT_RCU when cpu offlining

V1: https://lore.kernel.org/all/20220910203622.GI4315@paulmck-ThinkPad-P17-Gen-1/T/

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: rcu@vger.kernel.org

Pingfan Liu (3):
  rcu: Keep qsmaskinitnext fresh when rcutree_online_cpu()
  rcu: Resort to cpu_dying_mask for affinity when offlining
  rcu: coordinate tick dependency during concurrent offlining

 kernel/rcu/tree.c        | 21 ++++++++++++++-------
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h | 13 ++++++++++++-
 3 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.31.1

