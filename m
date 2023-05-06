Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698E4C77B7F
	for <rcu@archiver.kernel.org>; Sat,  6 May 2023 23:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEFXHH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 6 May 2023 19:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEFXHG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 6 May 2023 19:07:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0611310C4
        for <rcu@vger.kernel.org>; Sat,  6 May 2023 16:07:04 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba1cde4ee59so1871578276.1
        for <rcu@vger.kernel.org>; Sat, 06 May 2023 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683414423; x=1686006423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mvvFUComJxka0KtnpvFncoqWMniMbIOg2Q0amFnn+M=;
        b=uy99KHW3WLKbYfnoEQHObyv1l0Fko4TanlbD3IDG+5AAX1qjNaLCQy9P6VroKg8ozZ
         kbdCyK3oBXnYfi8mnFYIEg8uVdd9SJC0S38PKI8NVuofJxDX9u45RpqMPbWZOUJf20TJ
         ymK+AqWCo9Ke21DulIvr4UcMo1y9a2pvzlVyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683414423; x=1686006423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mvvFUComJxka0KtnpvFncoqWMniMbIOg2Q0amFnn+M=;
        b=OMykKRqVIhHQDEo4N6dcOh1uQS2ZBrRdLwmwdbW4NsS96SYUUdstMSrRpNRIkeplnW
         zUCaQDmFIDiiyLkXgm9xXAotJvxe78d/MuXhWJAU4OQL7t/y9E5ZsFgw9QKGNCsg4uDp
         3oW5LGJaScdw3U+i21J3SzMm/e45/4Bmp4ihuqCBfyFr7+X4AKhD0fkjrnuuuQQKruRq
         FN3sUXdNnACnIQlC3BPX+yOBJRDdvL/igQ/O8Csf54Yj7eEjW/OO78iWADusq8cJXEu/
         kCgO2ThNW5YczxzU4kH4a3pVEzzvoICV/tX2AY7l7vrRkIkYocSu/iwpiAY2JBFEuKLs
         MxUQ==
X-Gm-Message-State: AC+VfDwiJfWN0SUQWrpHT2WLtT4/MzvvqeLIR77e7JP4xMoBqf3JDfGC
        cx5Avehoz+DWDuEty4Tmgsxe8Ea8wYkXO6YNuOpwEA==
X-Google-Smtp-Source: ACHHUZ6GjAcz9OH9dK8wdzxsabqhnEslMz1RzRXeUyyOdvHgZavmwUi6U9sMIFosHS0JmW7nuUrxWKnQ2jLtirW9pso=
X-Received: by 2002:a25:a4a5:0:b0:ba2:ffa:9c0d with SMTP id
 g34-20020a25a4a5000000b00ba20ffa9c0dmr3854195ybi.47.1683414423123; Sat, 06
 May 2023 16:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <Y9o+FWwoLUdp2ees@google.com>
In-Reply-To: <Y9o+FWwoLUdp2ees@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 6 May 2023 18:06:49 -0500
Message-ID: <CAEXW_YQ+xqwgOqeq7vXrhtXzg_AuJLnekvkG6emwihJpGMF6ww@mail.gmail.com>
Subject: Re: LSFMMBPF proposal [MM]: Lazy RCU memory reclaim
To:     lsf-pc@lists.linux-foundation.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-mm <linux-mm@kvack.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,

> Title: Lazy RCU memory reclaim

I uploaded my slides to Google doc and opened it up for comment-level
access to everyone. Feel free to take a look or comment prior to my
talk: http://bit.ly/lsfmm23_rcu

It would be great to add the link to the schedule so that conference
attendees can view the slides in advance if they want to. I could not
find a way to do that, optionally - could the mm track or conference
organizers add the slides link under my talk to the schedule document?

thanks,

 - Joel
