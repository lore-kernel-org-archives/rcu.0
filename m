Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEDBEE49A0
	for <rcu@archiver.kernel.org>; Wed, 23 Aug 2023 03:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjHWDgg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Aug 2023 23:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjHWDgf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Aug 2023 23:36:35 -0400
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EDCCF2
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 20:36:28 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-2e-64e569d4637c
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 66.00.10987.4D965E46; Wed, 23 Aug 2023 07:07:16 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=h9yriN6Jk2Sx7BuByjImrwFZ1dM4PEHyfZgqsw66hQnTuOhvI8DWKjLA5x6LstlZ9
          5sDEmLjUKs5m46IdOhTpEzWxl29rueLPLsxlcvtrWJRl6xaKpg6KnM3l+pp8hCm1L
          yVMsEpIlPDQSIAgeKUZNkccclaOEOW2UpgZ1opVK0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=LBgBvC2GGYy3ALuIU5M5gka6jsUbTF9ZfrM3L062fAE44OUX2nZ+j//lhFPYxEESE
          A3bXDwJPN4wg6DW6nVGr52CiE3LlzPxfvghU2Sd72+34QBvFi7lk95a00zWSvr1+S
          dudGZfHHAnyCIIVmhhwd0IGWCx6NVIWHDBQnG5bJc=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 06:25:31 +0500
Message-ID: <66.00.10987.4D965E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     rcu@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 18:25:45 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVyyUKGW/dK5tMUgxmbNS3Ozj7H6sDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGknUXWAp2M1e09S9iaWB8zNTFyMkhIWAiMX3WBMYuRi4OIYE9
        TBKTV91mBnFYBFYzS3yZ/g3KecgscW7TGiaIsmZGiYdbvrCA9PMKWEu83N0OZjML6EncmDqF
        DSIuKHFy5hOouLbEsoWvgSZxANlqEl+7SkDCwgJiEp+mLWMHsUUExCX2vV0IVs4moC+x4msz
        I4jNIqAq8eDMa7AaIQEpiY1X1rNNYOSfhWTbLCTbZiHZNgth2wJGllWMEsWVuYnAYEs20UvO
        zy1OLCnWy0st0SvI3sQIDMTTNZpyOxiXXko8xCjAwajEw/tz3ZMUIdbEMqCuQ4wSHMxKIrzS
        3x+mCPGmJFZWpRblxxeV5qQWH2KU5mBREue1FXqWLCSQnliSmp2aWpBaBJNl4uCUamDkbP70
        dJPepqMxrz5LGAntz/P2Pe32/Uv400YJhcrFD8siH/ZeiP2r41gguFBpGvPxb5tYzl9mT2Nl
        tbcJFq7ex3Biqsmkm8FzFkYwh/6Lz4uZ+van5fUdl/XjN4u/2Rstqche8L79h6bUGu4yvS9f
        fXj1ni5X+hj9WnK7zts72ypCfXbZrpurxFKckWioxVxUnAgAlOp6rEACAAA=
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

