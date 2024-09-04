Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492221DB523
	for <rcu@vger.kernel.org>; Wed,  4 Sep 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459594; cv=none; b=l0zlxebc1KdASezlzGbnDuKtN+xPypaZ7dTo68toKxAC/8fBYk+03yfq5wGW9TWOv+BD2G0GwPbsOOXIvtgGXgB/I8KPeP0yCxHbwOjXc5WE6jcDIcUfTkCK8mpooPkaLmbWSubJMro5TBbyOC+rNv3XveFNCTFHExhN3Dr8wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459594; c=relaxed/simple;
	bh=mD9f5S4DEuGg1jzc0Ldg5GumyZEVw/s2kOOHo3uEVpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU7S2eQWbYD4D199Xkv5JKPYcFFTdKgC1SjxDzjr6t9R4XFKVg7wgQOXgGZLVGKVhh8ZhZ+AaH/TDwgnZZHu6wDiIkHbKpJDrfYmpA9xFER19r+NzcJlcDpWUNKYUSeXG882fWals39Z3Xkszb//eLjJ6sPsTg/2PV7CoXcU8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvl+nSVt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvl+nSVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725459592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuCkigoYy9EvKgW0pYC+K0vaMmgbR7ffC5hTK29y7rc=;
	b=dvl+nSVtKvo9dtaY5QwUNpR11mKhdZbnQwFtPs17CJ/yc0aaKIechIxTwwSjb6J5cPVwje
	pgoWfO1UB7FhZkzKjjVgUCow/wCy9Ebsyn4YuN1lfbWSv5KSm6nVMz+uHOqEA1mYlOLVI9
	W/nEPODst5tkx4LAJWrRiCq8F3kBcyE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-uvrvsX-tNhqVo-WhlJDdYw-1; Wed, 04 Sep 2024 10:19:51 -0400
X-MC-Unique: uvrvsX-tNhqVo-WhlJDdYw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6cf78470a56so24879467b3.3
        for <rcu@vger.kernel.org>; Wed, 04 Sep 2024 07:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459590; x=1726064390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuCkigoYy9EvKgW0pYC+K0vaMmgbR7ffC5hTK29y7rc=;
        b=BoxzCTgwTJDx3+pb5vQTmDQMMIlfm1KcMBTHuWtfjqQd0aHCLmo1qpDU0C7UanbNk5
         MSz/Vp9GNFU4894JbjmNld/BWRY1oXxu+czt2FcMg/tNJ5uTGzL8qdfmIRlRw4R8quQR
         4UiKBTemfmWp0CQ/vZAk41Dc50bokfCiki69gK1bqHaECxtO5S14Fq95EVeNbFEmbO3d
         u6zu8S8odYVU8jfp9fO1WwyjHH/LIPjPUc5zz0/2frOK8ehTK5RQBhPrxLrBzeBRxUTr
         ro2Vrg5qI112NSkYXN5a3F/O2Gq9Y8D9zN7xIqbPfzHNO5aGBrwg85G1jejimChkRMKw
         6nrw==
X-Forwarded-Encrypted: i=1; AJvYcCVgElkFQXLCGe+XDru64fuxcVM4786T94aTx+y6yMW2i7gwzS1IzWXN/43Bd+GogRD0A1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYqunER5dOi4fLPBCOUIrMgK51RgYHugdG+uwvLTsyim81H96
	PXUXEipiII3BmGDcmxH7rxfIlQW/A9DjRUfpwfoMEJ6mP4a/iauII57O94UC0NWlWCsQl+pz8sk
	g+urLGz+VPJQ6wkUD0Foe5IQeD8TeCOY2eZKbHDD1v/PvL4tXHKFyYFq8kumY8fGBVStTyHqVxU
	dcUZhvDtLrT/LSdTk6lOr+WNEc
X-Received: by 2002:a05:6902:168e:b0:e11:698f:8843 with SMTP id 3f1490d57ef6-e1d0e9eb2e9mr3269419276.44.1725459590501;
        Wed, 04 Sep 2024 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsnTbfou/A8LxL0fK6QJXDt09m8CtPZdb3+3imkX+k2RU4I4bqj44gQm96hRgWPBh0aaVGuUjc3PXGEU1/6fQ=
X-Received: by 2002:a05:6902:168e:b0:e11:698f:8843 with SMTP id
 3f1490d57ef6-e1d0e9eb2e9mr3269393276.44.1725459590233; Wed, 04 Sep 2024
 07:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv=v713xAFCKvkwr_0qyaQWkmfeDC2=bO7KKkui+p+ZeQ@mail.gmail.com>
In-Reply-To: <CA+G9fYv=v713xAFCKvkwr_0qyaQWkmfeDC2=bO7KKkui+p+ZeQ@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 4 Sep 2024 16:19:39 +0200
Message-ID: <CAOssrKdc4rcjJOqBnhbRa=R5yQY1erh+KuXr_2-nGTQ-qk3vOg@mail.gmail.com>
Subject: Re: next: rcu_preempt self-detected stall on CPU - queued_spin_lock_slowpath
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, yangyun50@huawei.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:06=E2=80=AFPM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
>
> The following kernel rcu info generated while running the test case
> selftests: memfd: run_fuse_test.sh on qemu-arm64 running Linux
> next-20240902. The qemu-arm64 did not recover.
>
> This build was created with kselftest merge configs.
>
> Anders bisected this to,
>   # first bad commit:
>     [5fb9c98e9d8ddf2abc645e2dcd9eb6703f77fdab]
>     fuse: add support for no forget requests

The bad commit was reverted from -next.

Thanks,
Miklos

